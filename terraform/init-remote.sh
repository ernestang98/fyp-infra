#!/bin/bash

cd terraform-manifests/remote-manifests
terraform init
terraform plan
terraform apply -auto-approve
