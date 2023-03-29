# Monitoring Resources

The resources in this directory aims to create the infrastructure needed for monitoring the deployment of our ASR system

# Project Structure

```bash
└── monitoring
    ├── efk-manifests
    ├── influxdb-manifests
    ├── minio-manifests
    ├── prometheus-thanos-manifests
    ├── grafana-json-manifests
    ├── init.sh
    └── destroy.sh
```

`efk-manifests` is the directory of kubernetes manifest files to deploy the EFK stack(elasticsearch, fluentd and kibana)

`influxdb-manifests` is the directory of kubernetes manifest files to deploy influxdb for our load testing suite to stream the metrics to for later visualisation

`minio-manifests` is the directory of kubernetes manifest files to deploy minio as an alternative for our thanos object store

`prometheus-thanos-manifests` is the directory of kubernetes manifest files to deploy prometheus with thanos and grafana

`grafana-json-manifests` is the directory of grafana JSON dashboard files used to monitor our load tests

`init.sh` is a bash script which automates the creation of the monitoring infrastructure

`destroy.sh` is a bash script which automates the destruction of the monitoring infrastructure

# Files to configure

1. `minio-manifests/minio.yaml`

    - $MINIO_ACCESS_KEY

    - $MINIO_SECRET_KEY

2. `minio-manifests/minio-pv.yaml`

    - $MODEL_SERVER - domain name or IP of EC2 server (if you are using AWS) hosting model (will also be used as server for minio's PV)

3. `minio-manifests/minio-pv.yaml`

    - $INGRESS - value of ELB (if you are using AWS) or domain name

    - $PASSWORD - password of Grafana admin account

4. `prometheus-thanos-manifests/thanos-storage-config.yaml` and `prometheus-thanos-manifests/thanos-values.yaml` (if you are using minio as object store)

    - $MINIO_ACCESS_KEY

    - $MINIO_SECRET_KEY

    - $MINIO_IP

    - $MINIO_PORT

    - $BUCKET_NAME

5. `prometheus-thanos-manifests/thanos-storage-config-aws.yaml`and `prometheus-thanos-manifests/thanos-values-aws.yaml`

    - $AWS_ACCESS_KEY

    - $AWS_SECRET_KEY

    - $REGION

    - $BUCKET_NAME