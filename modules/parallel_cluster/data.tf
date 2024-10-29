# Data block to generate a cluster configuration file from a template
data "template_file" "cluster_config" {
  template = file("${path.module}/config/rev_cluster_config.yaml.tpl")  # Path to the YAML template file
  vars = {
    subnet_id = var.subnet_id # Public subnet ID to be used in the configuration
    region = var.region # AWS region for resource deployment
    ssh_key = aws_key_pair.head_node_ssh_key.key_name # SSH key name for the head node
    post_install_bucket = var.post_install_bucket # S3 bucket for post-install scripts
    pass_and_attach_role_policy = var.pass_and_attach_role_policy
    s3_readonly_post_install_scripts_policy = var.s3_readonly_post_install_scripts_policy
  }
}
