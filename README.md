# fyp-infra

This repository contains the list of resources required for to set up the infrastructure before running the tests suite as written in [fyp-testing](https://github.com/ernestang98/fyp-testing).

# Trigger Tekton Pipeline via Git

```
git switch -c trigger-config
git commit --allow-empty -m "trigger webhook"
git push origin trigger-config
```