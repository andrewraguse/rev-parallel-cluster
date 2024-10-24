# Create a local file for the generated cluster configuration
resource "local_file" "cluster_yaml" {
  filename = "${path.module}/generated_cluster.yaml"
  content  = data.template_file.cluster_config.rendered
}

# Define an SSH key pair for the head node
resource "aws_key_pair" "head_node_ssh_key" {
  key_name = "head_node_ssh_key"  # Name of the key pair
  public_key = file("~/.ssh/id_rsa.pub")  # Load the public key from local system
}

# HSDS module for configuration
module "hsds" {
  source = "./hsds"
  region = var.region
  post_install_bucket = var.post_install_bucket
  hs_username = var.hs_username
  hs_password = var.hs_password
}

# ParallelCluster module configuration
module "pcluster" {
  source = "aws-tf/parallelcluster/aws"
  version = "1.0.0"
  region = var.region
  api_stack_name = var.api_stack_name
  api_version = var.api_version
  deploy_pcluster_api = false

  # Reference the YAML configuration file
  cluster_configs = {
    revcluster : {
      configuration = "${local_file.cluster_yaml.filename}"
    }
  }

  depends_on = [local_file.cluster_yaml]
}