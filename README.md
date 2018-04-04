# kubic-ingress-controller

This repo provides YAML files and instructions for deploying [nginx inress controller](https://github.com/kubernetes/ingress-nginx)
based on openSUSE images on Kubernetes (or preferably [Kubic / SUSE CaaSP](https://github.com/kubic-project)),

## Building images

Container images are stored in [Open Build System](https://build.opensuse.org)
in [home:mrostecki:branches:devel:CaaSP:kubic-container project](https://build.opensuse.org/project/show/home:mrostecki:branches:devel:CaaSP:kubic-container).

To build them, do:

```
osc co home:mrostecki:branches:devel:CaaSP:kubic-container
cd home:mrostecki:branches:devel:CaaSP:kubic-container
cd kubic-default-http-backend-image
osc build container
docker load -i /var/tmp/build-root/container-x86_64/usr/src/packages/KIWI-docker/kubic-default-http-backend.x86_64-4.0.0.docker.tar.xz
cd ..
cd kubic-nginx-ingress-controller-image
docker load -i /var/tmp/build-root/container-x86_64/usr/src/packages/KIWI-docker/kubic-nginx-ingress-controller.x86_64-4.0.0.docker.tar.xz
```

Then you can push those images to any registry you want.

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
