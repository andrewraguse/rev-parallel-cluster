data "template_file" "cluster_config" {
  template = file("${path.module}/config/rev_cluster_config.yaml.tpl")
  vars = {
    subnet = var.private_subnet_id
    region = var.region
    ssh_key = aws_key_pair.head_node_ssh_key.key_name # Pass the generated key name into the YAML
  }
}

resource "local_file" "cluster_yaml" {
  filename = "${path.module}/generated_cluster.yaml"
  content  = data.template_file.cluster_config.rendered
}

resource "aws_key_pair" "head_node_ssh_key" {
  key_name   = "head_node_ssh_key" # The name of the key pair
  public_key = file("~/.ssh/id_rsa.pub") # Safely load the public key from your local system
}

module "pcluster" {
    source  = "aws-tf/parallelcluster/aws"
    version = "1.0.0"

    region = var.region
    api_stack_name = var.api_stack_name
    api_version = var.api_version
    deploy_pcluster_api = false

    # Reference the generated YAML config file
    cluster_configs = {
        reVCluster : {
            configuration : "${path.module}/generated_cluster.yaml"
        }
    }
}