#!/bin/bash

cd load-test-manifests
cd automated-trigger
kubectl apply -f .
cd ..
cd ..
cd secrets
kubectl apply -f .
cd ..
cd tasks
kubectl apply -f .
cd ..
kubectl apply -f .
#cd manual-trigger
#kubectl apply -f .
#cd ..
cd ..

cd security-test-manifests
cd automated-trigger
kubectl apply -f .
cd ..
cd ..
cd secrets
kubectl apply -f .
cd ..
cd tasks
kubectl apply -f .
cd ..
kubectl apply -f .
#cd manual-trigger
#kubectl apply -f .
#cd ..
cd ..
