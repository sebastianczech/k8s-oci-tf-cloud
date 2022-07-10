output "ip_address_of_joined_node" {
  value = data.external.join_node_to_cluster.*.result.public_ip_of_joined_node
}

output "instance_public_ips" {
  value = local.instance_public_ips
}
