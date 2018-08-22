# kubic-ingress-controller

This repo provides YAML files and instructions for deploying [nginx ingress controller](https://github.com/kubernetes/ingress-nginx)
based on openSUSE images on Kubernetes (or preferably [Kubic / SUSE CaaSP](https://github.com/kubic-project)),

## Quickstart

The following instructions should work on any Kubernetes cluster which doesn't
have any ingress controller deployed.

If you don't have any Kubernetes cluster yet, you can try to set up [Kubic/CaaSP cluster](https://github.com/kubic-project/automation).

The other option is using minikube, which is the fastest way of setting up the
cluster (if you don't need multiple nodes):

```
sudo zypper in minikube
minikube start
```

To ensure that minikube isn't running the upstream version of ingress
controller:

```
minikube addons disable ingress
```

### Deployment

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

### Creating Ingress resource

Go to `example` directories:

```
cd examples
```

Then create deployments:

```
kubectl create -f deployments.yaml
```

Check whether deployments are ready. The proper output should look like:

```
$ kubectl get deployments
NAME          DESIRED   CURRENT   UP-TO-DATE   AVAILABLE   AGE
cheddar       2         2         2            2           2m
stilton       2         2         2            2           2m
wensleydale   2         2         2            2           2m
```

Then create services:

```
kubectl create -f services.yaml
```

Check whether they are created and havew cluster IPs. The proper output should
look like:

```
kubectl get services
NAME          TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)        AGE
cheddar       NodePort    10.107.142.179   <none>        80:32362/TCP   2s
kubernetes    ClusterIP   10.96.0.1        <none>        443/TCP        1h
stilton       NodePort    10.97.216.250    <none>        80:32498/TCP   2s
wensleydale   NodePort    10.106.201.25    <none>        80:31535/TCP   2s
```

If you are using minikube, you can check whether services are working by opening
them in browser with the following commands. Otherwise please skip this step:

```
minikube service stilton
minikube service cheddar
minikube service wensleydale
```

And finally create ingress object which will expose those services:

```
kubectl create -f ingress.yaml
```

Then check whether ingress is up. Example of the proper output:

```
$ kubectl get ingresses
NAME      HOSTS                                           ADDRESS   PORTS     AGE
cheese    stilton.local,cheddar.local,wensleydale.local             80        6s
$ kubectl describe ingress/cheese
Name:             cheese
Namespace:        default
Address:
Default backend:  default-http-backend:80 (<none>)
Rules:
  Host               Path  Backends
  ----               ----  --------
  stilton.local
                     /   stilton:80 (172.17.0.8:80)
  cheddar.local
                     /   cheddar:80 (172.17.0.10:80)
  wensleydale.local
                     /   wensleydale:80 (172.17.0.9:80)
Annotations:
  nginx.ingress.kubernetes.io/rewrite-target:  /
Events:
  Type    Reason  Age   From                      Message
  ----    ------  ----  ----                      -------
  Normal  CREATE  19s   nginx-ingress-controller  Ingress default/cheese
  Normal  CREATE  19s   nginx-ingress-controller  Ingress default/cheese
```

If you are using minikube and you want to access your services through ingress
from your host, you can update `/etc/hosts` to route requests to minikube
instance. If you are not using minikube, please skip this step.

```
echo "$(minikube ip) stilton.local cheddar.local wensleydale.local" | sudo tee -a /etc/hosts
```

Then you can visit `http://stilton.local` and the other ingress domains from
browser.
