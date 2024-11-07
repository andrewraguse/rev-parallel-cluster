Region: ${region}
Image:
  Os: alinux2
HeadNode:
  InstanceType: t2.large
  Networking:
    SubnetId: ${subnet_id}
  Ssh:
    KeyName: ${ssh_key}
  Iam:
    AdditionalIamPolicies:
      - Policy: arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore
      - Policy: ${pass_and_attach_role_policy}
      - Policy: ${output_files_bucket_policy}

Scheduling:
  Scheduler: slurm
  SlurmQueues:
    - Name: compute
      CapacityType: ONDEMAND
      Networking:
        SubnetIds:
          - ${subnet_id}
        AssignPublicIp: true
      Iam:
        AdditionalIamPolicies:
          - Policy: arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore
          - Policy: arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly
          - Policy: ${s3_readonly_post_install_scripts_policy}
          - Policy: ${pass_and_attach_role_policy}
      ComputeResources:
        - Name: queue1
          InstanceType: c5.2xlarge
          MinCount: 1
          MaxCount: 100
      CustomActions:
        OnNodeConfigured:
          Script: s3://${post_install_bucket}/hsds_post_install.sh
  SlurmSettings:
    QueueUpdateStrategy: TERMINATE
SharedStorage:
  - Name: ebs1
    MountDir: /shared
    StorageType: Ebs
    EbsSettings:
      VolumeType: gp2
      Size: 20
      DeletionPolicy: Delete