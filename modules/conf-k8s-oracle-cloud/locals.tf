locals {
  instance_public_ips = concat(data.external.join_node_to_cluster.*.result.public_ip_of_joined_node)
}