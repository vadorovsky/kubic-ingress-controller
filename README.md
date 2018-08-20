# kubic-ingress-controller

This repo provides YAML files and instructions for deploying [nginx ingress controller](https://github.com/kubernetes/ingress-nginx)
based on openSUSE images on Kubernetes (or preferably [Kubic / SUSE CaaSP](https://github.com/kubic-project)),

## Deployment

Use the following commands:

```
kubectl create -f namespace.yaml
kubectl create -f default-backend.yaml
kubectl create -f configmap.yaml
kubectl create -f tcp-services-configmap.yaml
kubectl create -f udp-services-configmap.yaml
kubectl create -f rbac.yaml
kubectl create -f with-rbac.yaml
```
