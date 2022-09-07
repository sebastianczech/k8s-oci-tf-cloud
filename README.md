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

## Configuration

In [k8s-oci](https://github.com/sebastianczech/k8s-oci/blob/main/README.md) whole configuration of Kubernetes cluster was done using Ansible playbooks. In this repository it's done by module publish in [Terraform Registry](https://registry.terraform.io/modules/sebastianczech/conf-k8s-oracle-cloud/oci/latest), which is doing similar things but in different way.

Most of the work is being done by resources of type ``null_resource`` with provisioners ``remote-exec`` or ``file``.

In order to configure infrastructure, just run below commands (if only you have properly configure environment variables in Terraform Cloud):

```bash
terraform init
terraform plan
terraform apply -auto-approve
```

If you want to connect to microk8s cluster from your computer, you can use commands:

```
terraform output -raw microk8s_config_public > ~/.kube/microk8s.conf
export KUBECONFIG=$KUBECONFIG:~/.kube/config:~/.kube/microk8s.conf
kubectl get all --all-namespaces
```

## Tests

### Pre-commit

Using [pre-commit](https://pre-commit.com/) there can be executed tests before every commit:

```
pre-commit run --all-files
```

which are using:
* [terraform-docs](https://github.com/terraform-docs/terraform-docs), which can run locally using command: 
```
terraform-docs markdown table --output-file DOCS.md --output-mode inject .
```
* [tfsec](https://github.com/aquasecurity/tfsec), which can run locally using command:
```
tfsec .
```
* [tflint](https://github.com/terraform-linters/tflint), which can run locally using command:
```
tflint --loglevel=trace --module .
```
* [checkov](https://github.com/bridgecrewio/checkov), which can run locally using command:
```
checkov --directory . --quiet --download-external-modules sebastianczech/infra-k8s-oracle-cloud/oci:0.0.7
```

### Terratest

Test are prepared using [Terratest](https://terratest.gruntwork.io/examples/). Before running tests for the first time, module needs to be initialized:

```
cd test
go mod init github.com/sebastianczech/k8s-oci-tf-cloud/test
go mod tidy
```

Next test can be executed by command (with ``-count=1`` to [disable caching](https://dev.to/mcaci/til-a-maybe-unexpected-usage-of-the-count-flag-in-go-tests-3dip)):

```
go test -v -timeout 30m -count=1
```