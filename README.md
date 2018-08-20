# kubic-ingress-controller

This repo provides YAML files and instructions for deploying [nginx ingress controller](https://github.com/kubernetes/ingress-nginx)
based on openSUSE images on Kubernetes (or preferably [Kubic / SUSE CaaSP](https://github.com/kubic-project)),

## Pulling the images

### openSUSE based images

In order to get the one based on openSUSE, you can pull them from the [openSUSE container registry](https://registry.opensuse.org). Look for the nginx-ingress-controller and for the default-http-backend images, and pull them.

Once you've done that, either tag them as the yaml files expect, or substitute the image name in the yaml files.

For example:

docker tag registry.opensuse.org/devel/caasp/kubic-container/container/kubic/nginx-ingress-controller:0.15.0 kubic/nginx-ingress-controller:latest

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
