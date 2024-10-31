#!/bin/bash
# shellcheck disable=SC2155

TOKEN=$(curl -X PUT -H "X-aws-ec2-metadata-token-ttl-seconds: 21600" http://169.254.169.254/latest/api/token)

export BUCKET_NAME=nrel-pds-hsds
export AWS_REGION=us-west-2
export AWS_S3_GATEWAY=http://s3.us-west-2.amazonaws.com/
export HSDS_ENDPOINT=http://localhost:5101
export LOG_LEVEL=INFO
export EC2_ID=$(curl -H "X-aws-ec2-metadata-token: $TOKEN" http://169.254.169.254/latest/meta-data/instance-id)
export EC2_TYPE=$(curl -H "X-aws-ec2-metadata-token: $TOKEN" http://169.254.169.254/latest/meta-data/instance-type)

echo On EC2 "$EC2_TYPE" with ID "$EC2_ID"
echo Checking HSDS and Docker...

check_hsds () {
    hsds_running=false
    if command -v docker &> /dev/null; then
        if [[ $(docker ps | wc -l) -ge 5 ]]; then
            hsds_running=true
        fi
    fi
}

check_hsds
if [ "$hsds_running" = true ]; then
    echo HSDS service running: $hsds_running
else
    (
        # use a filelock on ~/.flock.$EC2_ID to make sure only one
        # compute node runs this script per EC2 hardware
        flock -x -w 600 200 || exit 1

        # install docker if not found
        if ! command -v docker &> /dev/null; then
            sudo amazon-linux-extras install -y docker
            sudo systemctl start docker
            sudo chmod 666 /var/run/docker.sock
        fi

        # install docker-compose if not found
        if ! command -v docker-compose &> /dev/null; then
            sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
            sudo chmod +x /usr/local/bin/docker-compose
        fi

        check_hsds
        if [ "$hsds_running" = false ]; then
            # make sure docker is available
            sudo chmod 666 /var/run/docker.sock
            sudo groupadd docker
            sudo usermod -aG docker "$USER"
            sudo service docker start

            echo Starting HSDS local server...
            cd ~/hsds/ || exit
            sudo -E sh runall_custom.sh "$(nproc --all)"
            cd - || exit
        else
            echo HSDS service running: $hsds_running
        fi

        # give hsds a chance to warm up (not sure why but this helps a ton!)
        sleep 10s

    ) 200>/tmp/.rev_ec2_"$EC2_ID".flock
fi