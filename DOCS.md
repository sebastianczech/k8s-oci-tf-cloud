<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_conf-k8s-oracle-cloud"></a> [conf-k8s-oracle-cloud](#module\_conf-k8s-oracle-cloud) | ./modules/conf-k8s-oracle-cloud | n/a |
| <a name="module_infra-k8s-oracle-cloud"></a> [infra-k8s-oracle-cloud](#module\_infra-k8s-oracle-cloud) | sebastianczech/infra-k8s-oracle-cloud/oci | 0.0.7 |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_compartment_id"></a> [compartment\_id](#input\_compartment\_id) | n/a | `string` | n/a | yes |
| <a name="input_egress_security_rules"></a> [egress\_security\_rules](#input\_egress\_security\_rules) | n/a | `list(map(string))` | `[]` | no |
| <a name="input_fingerprint"></a> [fingerprint](#input\_fingerprint) | n/a | `string` | n/a | yes |
| <a name="input_id_rsa"></a> [id\_rsa](#input\_id\_rsa) | n/a | `string` | n/a | yes |
| <a name="input_id_rsa_pub"></a> [id\_rsa\_pub](#input\_id\_rsa\_pub) | n/a | `string` | n/a | yes |
| <a name="input_ingress_security_rules"></a> [ingress\_security\_rules](#input\_ingress\_security\_rules) | n/a | `list(map(string))` | `[]` | no |
| <a name="input_my_public_ip"></a> [my\_public\_ip](#input\_my\_public\_ip) | n/a | `string` | n/a | yes |
| <a name="input_private_key"></a> [private\_key](#input\_private\_key) | n/a | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | n/a | `string` | n/a | yes |
| <a name="input_tenancy_ocid"></a> [tenancy\_ocid](#input\_tenancy\_ocid) | n/a | `string` | n/a | yes |
| <a name="input_user_ocid"></a> [user\_ocid](#input\_user\_ocid) | n/a | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_availability_domain"></a> [availability\_domain](#output\_availability\_domain) | availability domain |
| <a name="output_compute_instances"></a> [compute\_instances](#output\_compute\_instances) | names and IPs of created instances |
| <a name="output_compute_instances_public_ip"></a> [compute\_instances\_public\_ip](#output\_compute\_instances\_public\_ip) | public IPs of created nodes |
| <a name="output_lb_public_ip"></a> [lb\_public\_ip](#output\_lb\_public\_ip) | public IPs of LB |
| <a name="output_master_public_ip"></a> [master\_public\_ip](#output\_master\_public\_ip) | public IPs of master node |
| <a name="output_microk8s_config_private"></a> [microk8s\_config\_private](#output\_microk8s\_config\_private) | kubectl configuration file with private IP |
| <a name="output_microk8s_config_public"></a> [microk8s\_config\_public](#output\_microk8s\_config\_public) | kubectl configuration file with public IP |
| <a name="output_subnet_cidr"></a> [subnet\_cidr](#output\_subnet\_cidr) | CIDR block of the core subnet |
| <a name="output_subnet_id"></a> [subnet\_id](#output\_subnet\_id) | ID of the core subnet |
| <a name="output_subnet_state"></a> [subnet\_state](#output\_subnet\_state) | the state of the subnet |
| <a name="output_vcn_cidr"></a> [vcn\_cidr](#output\_vcn\_cidr) | CIDR block of the core VCN |
| <a name="output_vcn_id"></a> [vcn\_id](#output\_vcn\_id) | ID of the core VCN |
| <a name="output_vcn_state"></a> [vcn\_state](#output\_vcn\_state) | the state of the VCN |
<!-- END_TF_DOCS -->