#!/bin/bash

# kubectl delete ns monitoring
# kubectl -n monitoring delete secret thanos-objstore-config
# helm uninstall prometheus prometheus-community/kube-prometheus-stack -f ./prometheus-thanos-manifests/prometheus-values.yaml -n monitoring
# helm uninstall thanos bitnami/thanos -f ./prometheus-thanos-manifests/thanos-values.yaml -n monitoring

kubectl delete ns monitoring
kubectl -n monitoring delete secret thanos-objstore-config
helm uninstall prometheus prometheus-community/kube-prometheus-stack -f ./prometheus-thanos-manifests/prometheus-values.yaml -n monitoring
helm uninstall thanos bitnami/thanos -f ./prometheus-thanos-manifests/thanos-values-aws.yaml -n monitoring

kubectl delete secret influxdb-creds -n monitoring
kubectl delete -f ./influxdb-manifests/influxdb-pvc.yaml -n monitoring
kubectl delete -f ./influxdb-manifests/influxdb-deployment.yaml -n monitoring
kubectl delete -f ./influxdb-manifests/influxdb-service.yaml -n monitoring

kubectl delete -f ./efk-manifests/efk-es-dep.yaml -n monitoring
kubectl delete -f ./efk-manifests/efk-es-svc.yaml -n monitoring
kubectl delete -f ./efk-manifests/efk-kibana.yaml -n monitoring
kubectl delete -f ./efk-manifests/efk-fluentd.yaml -n monitoring