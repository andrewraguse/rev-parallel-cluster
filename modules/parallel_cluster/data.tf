data "template_file" "cluster_config" {
  template = file("${path.module}/config/rev_cluster_config.yaml.tpl")
  vars = {
    subnet = var.private_subnet_id
    region = var.region
    ssh_key = aws_key_pair.head_node_ssh_key.key_name # Pass the generated key name into the YAML
  }
}