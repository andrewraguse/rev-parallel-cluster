# Output the clusters from the ParallelCluster module
output "clusters" {
  value = module.pcluster.clusters
}

# Output the content of the generated YAML file for debugging
output "yaml_content_debug" {
  value = local_file.cluster_yaml.content
}