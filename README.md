## To delete cache

`find . -type f -name ".terraform.lock.hcl" -exec rm -f {} \;`

`find . -type d -name ".terraform" -prune -exec rm -rf {} \;`

## To initialize project

`gcloud services enable compute.googleapis.com`

`gcloud auth application-default login`

`terraform init`

## Previous HW:

https://registry.terraform.io/providers/hashicorp/google/latest/docs/guides/getting_started

Types and Values: https://developer.hashicorp.com/terraform/language/expressions/types

References to Values: https://developer.hashicorp.com/terraform/language/expressions/references

## Hands-on

### PART 1:
- Added external IP address as output based on the doc
https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_instance

### PART 2:
- Create subnet for VM instance
- Add WAF to allow 443 and 80 from 0.0.0.0
- Allow 22 to SSH
- Install apache2 to serve a basic HTML with metadata_startup_script

### PART 3:
- Seperate configs into new files
- Create bucket with terraform

### PART 4:
- Depends on attribute, tags for best-practice
- Store state in the bucket

### PART 5:
- Use modules
https://github.com/orgs/terraform-google-modules/repositories

## Do not forget to delete resources
`terraform destroy`