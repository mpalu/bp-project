# Brasil Paralelo Project

This project creates a local Kubernetes cluster using [Kind][] and deploy two applications, `authentication` and `feed`.

## Pre-requisites

- [Kind][] (will be installed automatically)
- [Docker][]
- [kubectl][]
- [curl][]
- [Helm3][] (optional)

Also, ensure the port 80 is not in use by any other service in your system. It will be used by the Ingress to expose the application.

## Run

Execute the helper script to create the cluster and deploy the Kubernetes resources for `auth` and `feed` applications (Deployment, Service, Ingress, HorizontalPodAutoscaler, PodDisruptionBudget, Ambassor Ingress Controller):

```
./kubernetes/setup.sh
```

Test the application:

```
curl -H "Authorization: Bearer 66ec51ac-72ea-479d-8b5f-d99eede929f0" -v localhost/feed/patriota # 200 OK

curl -H "Authorization: Bearer 66ec51ac-72ea-479d-8b5f-d99eede929f0" -v localhost/feed/premium # 403 Forbidden

curl -H "Authorization: Bearer 2974ef88-cd63-4418-95cd-106c616fd08f" -v localhost/feed/patriota # 200 OK

curl -H "Authorization: Bearer 2974ef88-cd63-4418-95cd-106c616fd08f" -v localhost/feed/premium # 200 OK
```

_INFO:_ The Ingress controller could take some minutes to be ready, so the application could take a while to respond to the curl requests

The cluster and its resources could be completelly removed by running:

```
/tmp/kind delete cluster # use the proper path to the kind binary if installed in a different directory
```

## Other

There is a Helm chart in the repository as reference. As a personal choice, the raw Kuerbenetes resources are deployed rather than the Helm chart, but it could be deployed using Helm3 as well.

```
helm install --name auth --namespace app kubernetes/helm -f kubernetes/helm/deployments/auth.yaml

helm install --name feed --namespace app kubernetes/helm -f kubernetes/helm/deployments/feed.yaml
```

[kind]: https://kind.sigs.k8s.io/docs/user/quick-start/#installation
[docker]: https://docs.docker.com/engine/install/
[kubectl]: https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/
[curl]: https://curl.se/download.html
[helm3]: https://helm.sh/docs/intro/install/
