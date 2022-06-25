# output "ip_address_of_joined_node" {
#   value = data.external.join_node_to_cluster.*.result.public_ip
# }

output "ip_address_for_qa" {
  value = data.external.get_ip_addres_using_python.result.ip_address
}

output "port_num_for_qa" {
  value = data.external.get_ip_addres_using_python.result.port_num
}