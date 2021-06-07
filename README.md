# Static File Server
```
cd fileserver
docker image build -t demo-k8s-fileserver .
```
TEST
```
docker container run --rm -it -v "$(pwd)/assets/":/www/data/ -p 90:80 --name fileserver demo-k8s-fileserver
curl localhost:9090/images/sample.jpeg > test.jpg
```

Publish Image
```
docker image ls
docker image tag demo-k8s-fileserver lqp2792/demo-k8s-fileserver:1.0.0
docker push lqp2792/demo-k8s-fileserver:1.0.0
```

```

kubectl create deployment fileserver --image=lqp2792/demo-k8s-fileserver -o=yaml --dry-run=client > deployment.yaml
# Add resources (requests, limits)
kubectl create service clusterip fileserver --tcp=80:80 -o=yaml --dry-run=client > service.yaml
# Add SessionAffinity: None to service
```

```
minikube mount /vagrant_data/assets:/data/assets
kubectl apply -f deployment.yaml
kubectl apply -f service.yaml
```

# Redis
```
cd redis
kubectl create secret generic redis-passwd --from-literal=passwd=12345678 -o=yaml --dry-run=client > secret.yaml
# Copy statefulset.yaml config on k8s docs
kubectl create configmap redis-startup --from-file=startup.sh=startup.sh -o=yaml --dry-run=client > config-startup.yaml
kubectl create service clusterip redis-write --clusterip='None' --tcp=6379 -o=yaml --dry-run=client > service-write.yaml
# Fix labels
kubectl create service clusterip redis-read --tcp=6379 -o=yaml --dry-run=client > service-read.yaml
# Fix labels
```

```
kubectl apply -f secret.yaml
kubectl apply -f config-startup.yaml
kubectl apply -f statefulset.yaml
```

```

kubectl exec -it redis-1 -- /bin/bash
> redis-cli
> AUTH "default" 12345678
> role
kubectl get pvc
kubectl get pv
```

# Frontend
```
cd frontend
docker image build -t demo-k8s-frontend .
docker container run -it --rm --name demo-frontend demo-k8s-frontend
docker image ls
docker image tag demo-k8s-frontend lqp2792/demo-k8s-frontend:1.0.0
docker push lqp2792/demo-k8s-frontend:1.0.0
```

```
kubectl create deployment frontend --image lqp2792/demo-k8s-frontend -o=yaml --dry-run=client > deployment.yaml
kubectl create service clusterip frontend --tcp=8080:8080 -o=yaml --dry-run=client > service.yaml

kubectl create configmap frontend-config --from-literal=journalEntries=10 -o=yaml --dry-run=client > config.yaml
```

```
kubectl create -f config.yaml
kubectl get configmaps
```

# Ingress

```
minikube addons enable ingress
kubectl create ingress frontend-ingress --class=default --rule="/api=frontend:8080" -o=yaml --dry-run=client > ingress.yaml
```


# Debug DNS
```
kubectl apply -f https://k8s.io/examples/admin/dns/dnsutils.yaml
```


# Helm

```
```