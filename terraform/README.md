# Cloud Resources

The resources in this directory aims to create the infrastructure needed for run our solution on cloud

# Project Structure

```bash
└── terraform
    ├── terraform-manifests
    │   ├── remote-manifests
    │   └── manifests
    ├── init-remote.sh
    ├── init.sh
    ├── destroy-remote.sh
    └── destroy.sh
```

`remote-manifests` is the directory of terraform manifest files which will create of the infrastructure to allow for remote versioning on terraform (used by `init-remote.sh` and `destroy-remote.sh`)

`manifests` is the directory of terraform manifest files which will create the cloud infrastructure terraform (used by `init.sh` and `destroy.sh`)

`init-remote.sh` is a bash script which automates the creation of the infrastructure to allow for remote versioning on terraform (run this first)

`init.sh` is a bash script which automates the creation of the cloud infrastructure (run this second)

`destroy-remote.sh` is a bash script  which automates the destruction of the infrastructure to allow for remote versioning on terraform

`destroy.sh` is a bash script which automates the destruction of the cloud infrastructure

# Files to configure

1. `terraform-manifests/remote-manifests/variables.tf`

    - $REGION

    - $ACCESS_KEY

    - $SECRET_KEY

2. `terraform-manifests/manifests/variables.tf`

    - $REGION

    - $ACCESS_KEY

    - $SECRET_KEY

    - $REMOTE_BUCKET (obtain from running `terraform output` in `terraform-manifests/remote-manifests`)

    - $REMOTE_DB (obtain from running `terraform output` in `terraform-manifests/remote-manifests`)
