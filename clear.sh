#!/bin/bash

for n in $(kubectl get namespaces -o jsonpath={..metadata.name}); do
  kubectl delete --all --namespace=$n prometheus,servicemonitor,podmonitor,alertmanager
done
kubectl delete -f prometheus-operator-0.46.0/bundle.yaml
kubectl delete -f monitoring/sa.yaml