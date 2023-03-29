#!/bin/bash

cd load-test-manifests
cd automated-trigger
kubectl delete -f .
cd ..
cd ..
cd secrets
kubectl delete -f .
cd ..
cd tasks
kubectl delete -f .
cd ..
kubectl delete -f .
#cd manual-trigger
#kubectl delete -f .
#cd ..
cd ..

cd security-test-manifests
cd automated-trigger
kubectl delete -f .
cd ..
cd ..
cd secrets
kubectl delete -f .
cd ..
cd tasks
kubectl delete -f .
cd ..
kubectl delete -f .
#cd manual-trigger
#kubectl delete -f .
#cd ..
cd ..
