#!/bin/bash

cd terraform-manifests/manifests
terraform init
terraform plan
terraform apply -auto-approve
sudo rm key.pem
sudo rm key.pub
terraform output -raw private_key > key.pem
sudo chmod 400 key.pem
ssh-keygen -y -f key.pem > key.pub
printf "SSH into model server and verify that models have been downloaded and unzipped into \"/var/nfs/general\"\n"
printf "Verify that \"/var/nfs/general\" is readable and is owned by \"nobody\" and belongs to \"nogroup\"\n"
cd ..
cd ..
