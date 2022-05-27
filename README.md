# k8s-oci-tf-cloud

Infrastructure for Kubernetes provisioned in Oracle Cloud with the use of Terraform Cloud

## Authentication

In order to use OCI API, it was created variable set in Terraform Cloud and there were create environment variables with all OCI settings as [described on Oracle documentation for Terraform provider](https://docs.oracle.com/en-us/iaas/Content/API/SDKDocs/terraformproviderconfiguration.htm):

```
TF_VAR_tenancy_ocid
TF_VAR_compartment_ocid
TF_VAR_user_ocid
TF_VAR_private_key
TF_VAR_fingerprint
TF_VAR_region
```

Variable set for defined environment variables was created as [described on Terraform documentation](https://learn.hashicorp.com/tutorials/terraform/cloud-create-variable-set?in=terraform/cloud-get-started).

One of the variables is fingerprint, which was created by command:

```
openssl rsa -pubout -outform DER -in ~/.oci/oci_api_key.pem | openssl md5 -c
```

## Provisioning

At first to verify authentication from Terraform code, it was created simple code as [described on Terraform tutorial for Oracle Cloud](https://learn.hashicorp.com/tutorials/terraform/infrastructure-as-code?in=terraform/oci-get-started).
