# Local variable to hold cluster configurations
locals {
  cluster_configs = {
    revcluster : {
      configuration = "${path.module}/generated_cluster.yaml"  # Path to the generated cluster configuration file
    }
  }
}