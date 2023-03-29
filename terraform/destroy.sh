#!/bin/bash

cd terraform-manifests/manifests
aws s3 rm s3://$(terraform output -raw s3_bucket_name) --recursive
terraform destroy -auto-approve
cd ..
cd ..