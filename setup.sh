# kubectl create my-service/database-stateful-set-yaml
# kubectl create my-service/middle-tier.yaml
# kubectl create my-service/configs.yaml

#!/bin/bash

# Setup Helm
helm repo add stable https://charts.helm.sh/stable
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update

# Setup Monitoring
PROMETHEUS_DIR="prometheus-operator-0.46.0"
if [[ ! -d "$PROMETHEUS_DIR" ]]; then
    sudo apt install -y unzip
    wget -O "${PROMETHEUS_DIR}.zip"  https://github.com/prometheus-operator/prometheus-operator/archive/v0.46.0.zip
    unzip "${PROMETHEUS_DIR}.zip"
    rm "${PROMETHEUS_DIR}.zip"
fi
kubectl create namespace monitoring
kubectl apply -f "${PROMETHEUS_DIR}"/bundle.yaml
kubectl apply -f monitoring/sa.yaml

# Setup Logging
kubectl create namespace logging

# Setup Application