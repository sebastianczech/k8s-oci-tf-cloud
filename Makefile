check:
	terraform fmt -recursive
	terraform validate
	tfsec .
	tflint .

pre-commit:
	pre-commit run --all-files

plan:
	terraform plan

apply:
	terraform apply -auto-approve
