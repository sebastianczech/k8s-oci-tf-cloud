# k8s-oci-tf-cloud

## About repository

Infrastructure for Kubernetes provisioned in Oracle Cloud with the use of Terraform Cloud.
Whole idea of repository is based on [k8s-oci](https://github.com/sebastianczech/k8s-oci), which is delivering code to setup Kubernetes cluster using tools on your local machine.

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

## Infrastructure

Infrastructure provisioning is the same as in approach described in [k8s-oci](https://github.com/sebastianczech/k8s-oci/blob/main/README.md), where also Terraform was used to created all required objects in Oracle Cloud, besides 2 things:
* Terraform state is no longer stored on local machine, but in Terraform Cloud
* variables with sercet are defined in Terraform Cloud, not ``terraform.tfvars`` stored locally