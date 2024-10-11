output "clusters" {
  value = module.pcluster.clusters
}

output "yaml_content_debug" {
  value = local_file.cluster_yaml.content
}