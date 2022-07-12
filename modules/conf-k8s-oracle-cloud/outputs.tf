output "master_public_ip" {
  value = local.master_public_ip
}

output "microk8s_config" {
  value = data.external.microk8s_config.result.configuration
}
