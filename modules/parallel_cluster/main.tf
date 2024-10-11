resource "local_file" "cluster_yaml" {
  filename = "${path.module}/generated_cluster.yaml"
  content  = data.template_file.cluster_config.rendered
}

resource "aws_key_pair" "head_node_ssh_key" {
  key_name   = "head_node_ssh_key" # The name of the key pair
  public_key = file("~/.ssh/id_rsa.pub") # Safely load the public key from your local system
}

module "hsds" {
  source = "./hsds"
  region = var.region
  post_install_bucket = var.post_install_bucket
  hs_username = var.hs_username
  hs_password = var.hs_password
}

module "pcluster" {
    source  = "aws-tf/parallelcluster/aws"
    version = "1.0.0"

    region = var.region
    api_stack_name = var.api_stack_name
    api_version = var.api_version
    deploy_pcluster_api = false

    # Use the content of the YAML file
    cluster_configs = {
      reVCluster : {
        configuration = "${local_file.cluster_yaml.filename}"
      }
    }

    depends_on = [local_file.cluster_yaml]
}