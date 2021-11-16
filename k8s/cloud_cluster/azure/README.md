## Terraform init

terraform init -backend-config=client_id=[CLIENT_ID] -backend-config=client_secret=[CLIENT_SECRET] -backend-config=subscription_id=[SUB_ID] -backend-config=tenant_id=[TENANT_ID] -reconfigure

terraform init -backend-config=secret/secret.tfvars -reconfigure

* static values:
  * resource_group_name
  * storage_account_name
  * container_name
  * key

* RBAC
  * Custom Role: for terraform creation
## Terraform plan

terraform plan -var-file=vars.tfvars -var=client_id=[CLIENT_ID] -var=client_secret=[CLIENT_SECRET] -var=subscription_id=[SUB_ID]-var=tenant_id=[TENANT_ID]

terraform plan -var-file=vars.tfvars -var-file=secret/secret.tfvars

## Terraform apply

terraform apply -var-file=vars.tfvars -var-file=secret/secret.tfvars

terraform apply -var-file=vars.tfvars -var-file=secret/secret.tfvars -auto-approve

## Terraform destroy

terraform destroy -var-file=vars.tfvars -var-file=secret/secret.tfvars

## Custom role
* Create a custom role: 
  * az role definition create --role-definition @custom_contributor.json
  * az role definition update --role-definition @custom_contributor.json
* Assign this role at subscription level

## Error:
* "The subscription is not registered to use namespace 'Microsoft.ContainerService': https://docs.microsoft.com/en-us/azure/azure-resource-manager/troubleshooting/error-register-resource-provider

### Connect to worker node on AKS:
* command: kubectl debug node/[worker_node_name] -it --image=mcr.microsoft.com/aks/fundamental/base-ubuntu:v0.0.11
* docs: https://docs.microsoft.com/en-us/azure/aks/ssh