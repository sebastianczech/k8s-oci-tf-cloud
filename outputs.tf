output "availability_domain" {
  description = "availability domain"
  value       = module.infra-k8s-oracle-cloud.availability_domain
}

output "vcn_state" {
  description = "the state of the VCN"
  value       = module.infra-k8s-oracle-cloud.vcn_state
}

output "vcn_cidr" {
  description = "CIDR block of the core VCN"
  value       = module.infra-k8s-oracle-cloud.vcn_cidr
}

output "vcn_id" {
  description = "ID of the core VCN"
  value       = module.infra-k8s-oracle-cloud.vcn_id
}

output "subnet_state" {
  description = "the state of the subnet"
  value       = module.infra-k8s-oracle-cloud.subnet_state
}

output "subnet_id" {
  description = "ID of the core subnet"
  value       = module.infra-k8s-oracle-cloud.subnet_id
}

output "subnet_cidr" {
  description = "CIDR block of the core subnet"
  value       = module.infra-k8s-oracle-cloud.subnet_cidr
}

output "compute_instances_public_ip" {
  description = "public IPs of created nodes"
  value       = module.infra-k8s-oracle-cloud.compute_instances_public_ip
}

output "compute_instances" {
  value       = module.infra-k8s-oracle-cloud.compute_instances
  description = "names and IPs of created instances"
}

output "lb_public_ip" {
  description = "public IPs of LB"
  value       = module.infra-k8s-oracle-cloud.lb_public_ip
}

output "ip_address_of_joined_node" {
  description = "public IPs of nodes which joined to cluster"
  value       = module.conf-k8s-oracle-cloud.ip_address_of_joined_node
}