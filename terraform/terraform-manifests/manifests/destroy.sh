aws s3 rm s3://$(terraform output -raw s3_bucket) --recursive

terraform destroy -auto-approve
