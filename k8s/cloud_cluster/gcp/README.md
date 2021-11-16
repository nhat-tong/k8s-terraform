## Terraform init

```
terraform init -backend-config=credentials=[SA.json] -backend-config=bucket=[BUCKET_NAME] -backend-config=prefix=[PREFIX] -reconfigure
```

or 

```
terraform init -backend-config=secret/gcs.tfvars -reconfigure
```

## Terraform plan

terraform plan -var-file=vars.tfvars

## Terraform apply

terraform apply -var-file=vars.tfvars