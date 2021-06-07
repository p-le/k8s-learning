#!/bin/bash

kubectl delete -f frontend/deployment.yaml
kubectl delete -f frontend/config.yaml
kubectl delete -f frontend/service.yaml

kubectl delete -f fileserver/deployment.yaml
kubectl delete -f fileserver/service.yaml

kubectl delete -f redis/statefulset.yaml
kubectl delete -f redis/config-startup.yaml
kubectl delete -f redis/secret.yaml
kubectl delete -f redis/service-read.yaml