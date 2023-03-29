# Decoding SDK

The resources in this directory aims to provide the infrastructure to deploy our ASR system

# Project Structure

```bash
└── decoding
    ├── decoding-manifests
    ├── init.sh
    └── destroy.sh
```

`decoding-manifests` is the directory of kubernetes manifest files to deploy the ASR system

`init.sh` is a bash script which automates the creation of the ASR system

`destroy.sh` is a bash script which automates the destruction of the ASR system

# Files to configure

1. `decoding-manifests/decoding-sdk-server-ingress.yaml`

    - $HOST - value of ELB (if you are using AWS) or domain name

2. `decoding-manifests/decoding-sdk-worker-pv.yaml`

    - $MODEL_SERVER - domain name or IP of EC2 server (if you are using AWS) hosting model