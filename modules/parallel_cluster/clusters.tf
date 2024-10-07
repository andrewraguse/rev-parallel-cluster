locals {
  cluster_configs = {
    reVCluster : {
      configuration : "${path.module}/generated_cluster.yaml"
    }
  }
}