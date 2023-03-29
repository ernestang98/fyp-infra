#!/bin/bash

kubectl delete namespace -n asr-engine
kubectl delete -f ./decoding-manifests -n asr-engine