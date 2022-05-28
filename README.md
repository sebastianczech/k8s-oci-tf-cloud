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
openssl rsa -pubout -outform DER -in oci_private.cer | openssl md5 -c
```

While running plan, there was problem with private key. Following error message was displayed:

```
error: can not create client, bad configuration: did not find a proper configuration for private key
```

In environment variables in Terraform Cloud multi-line values cannot be stored (PEM key has many lines), so as suggested on discussion [Multi-line Variable problem](https://discuss.hashicorp.com/t/multi-line-variable-problem/10750), private key was removed from environment variables in Terraform Cloud and stored as sensitive Terraform variable. 

## Provisioning

At first to verify authentication from Terraform code, it was created simple code as [described on Terraform tutorial for Oracle Cloud](https://learn.hashicorp.com/tutorials/terraform/infrastructure-as-code?in=terraform/oci-get-started).
