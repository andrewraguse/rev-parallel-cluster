# Data block to generate a cluster configuration file from a template
data "template_file" "cluster_config" {
  template = file("${path.module}/config/rev_cluster_config.yaml.tpl")  # Path to the YAML template file
  vars = {
    private_subnet_id = var.private_subnet_id # Private subnet ID to be used in the configuration
    public_subnet_id = var.public_subnet_id # Public subnet ID to be used in the configuration
    region = var.region # AWS region for resource deployment
    ssh_key = aws_key_pair.head_node_ssh_key.key_name # SSH key name for the head node
    post_install_bucket = var.post_install_bucket # S3 bucket for post-install scripts
    pcluster_ec2_role = var.pcluster_ec2_role # Role for EC2 instances in the ParallelCluster
  }
}
