Region: ${region}
Image:
  Os: alinux2

HeadNode:
  InstanceType: t2.large
  Networking:
    SubnetId: ${subnet}
  Ssh:
    KeyName: ${ssh_key}
  Iam:
    AdditionalIamPolicies:
      - Policy: arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore

Scheduling:
  Scheduler: slurm
  SlurmQueues:
    - Name: compute
      CapacityType: ONDEMAND
      Networking:
        SubnetIds:
          - ${subnet}
      Iam:
        AdditionalIamPolicies:
          - Policy: arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore
      ComputeResources:
        - Name: compute-resource-1
          InstanceType: c5.2xlarge
          MinCount: 0
          MaxCount: 2
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
