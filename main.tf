module "infra-k8s-oracle-cloud" {
  source = "./modules/infra-k8s-oracle-cloud"

  compartment_id         = var.compartment_id
  my_public_ip           = var.my_public_ip
  id_rsa_pub             = var.id_rsa_pub
  ingress_security_rules = var.ingress_security_rules
  egress_security_rules  = var.egress_security_rules
  instance_count         = var.instance_count
}

module "conf-k8s-oracle-cloud" {
  source = "./modules/conf-k8s-oracle-cloud"

  compute_instances = module.infra-k8s-oracle-cloud.compute_instances
  lb_id             = module.infra-k8s-oracle-cloud.lb_id
  subnet_cidr       = module.infra-k8s-oracle-cloud.subnet_cidr
  my_public_ip      = var.my_public_ip
  id_rsa            = var.id_rsa
}
