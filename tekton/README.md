# Tekton Resources

The resources in this directory aims to create the infrastructure needed to deploy tekton and run our pipelines

# Project Structure

```bash
└── tekton
    ├── load-test-manifests
    ├── security-test-manifests
    ├── init.sh
    └── destroy.sh
```

`load-test-manifests` is the directory of kubernetes manifest files to deploy our load testing pipeline

`security-test-manifests` is the directory of kubernetes manifest files to deploy our security testing pipeline

`init.sh` is a bash script which automates the creation of the tekton pipelines

`destroy.sh` is a bash script which automates the destruction of the tekton pipelines

# Files to configure

1. `*/secrets/aws-secrets.yaml`

    - $ACCESS_KEY

    - $SECRET_KEY

    - $REGION

2. `*/secrets/git-clone-secrets.yaml`

    - $USERNAME

    - $PASSWORD

3. `*/secrets/git-trigger-secrets.yaml`

    - $SECRET

4. `*/secrets/gmail-secrets.yaml`

    - $USERNAME

    - $PASSWORD

5. `*/secrets/slack-secrets.yaml`

    - $SLACK_WEBHOOK