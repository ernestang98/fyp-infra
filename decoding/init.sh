#!/bin/bash

kubectl create namespace -n asr-engine
kubectl apply -f ./decoding-manifests -n asr-engine