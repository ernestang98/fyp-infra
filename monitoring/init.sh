#!/bin/bash

# kubectl create ns monitoring
# kubectl -n monitoring create secret generic thanos-objstore-config --from-file=thanos.yaml=./prometheus-thanos-manifests/thanos-storage-config.yaml
# helm repo add bitnami https://charts.bitnami.com/bitnami
# helm repo update
# helm install prometheus prometheus-community/kube-prometheus-stack -f ./prometheus-thanos-manifests/prometheus-values.yaml -n monitoring
# helm install thanos bitnami/thanos -f ./prometheus-thanos-manifests/thanos-values.yaml -n monitoring

kubectl create ns monitoring
kubectl -n monitoring create secret generic thanos-objstore-config --from-file=thanos.yaml=./prometheus-thanos-manifests/thanos-storage-config-aws.yaml
helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo update
helm install prometheus prometheus-community/kube-prometheus-stack -f ./prometheus-thanos-manifests/prometheus-values.yaml -n monitoring
helm install thanos bitnami/thanos -f ./prometheus-thanos-manifests/thanos-values-aws.yaml -n monitoring

USER=USER
PASSWORD=PASSWORD
ROOT_USER=ROOT_USER
ROOT_PASSWORD=ROOT_PASSWORD
DATABASE=DATABASE
kubectl create secret generic influxdb-creds \
    --from-literal=INFLUXDB_DB=$DATABASE \
    --from-literal=INFLUXDB_USER=$USER \
    --from-literal=INFLUXDB_USER_PASSWORD=$PASSWORD \
    --from-literal=INFLUXDB_READ_USER=readonly \
    --from-literal=INFLUXDB_ADMIN_USER=$ROOT_USER \
    --from-literal=INFLUXDB_ADMIN_USER_PASSWORD=$ROOT_PASSWORD \
    --from-literal=INFLUXDB_HOST=influxdb \
    --from-literal=INFLUXDB_HTTP_AUTH_ENABLED=true \
    -n monitoring
kubectl apply -f ./influxdb-manifests/influxdb-pvc.yaml -n monitoring
kubectl apply -f ./influxdb-manifests/influxdb-deployment.yaml -n monitoring
kubectl apply -f ./influxdb-manifests/influxdb-service.yaml -n monitoring

kubectl apply -f ./efk-manifests/efk-es-dep.yaml -n monitoring
kubectl apply -f ./efk-manifests/efk-es-svc.yaml -n monitoring
kubectl apply -f ./efk-manifests/efk-kibana.yaml -n monitoring
kubectl apply -f ./efk-manifests/efk-fluentd.yaml -n monitoring