#!/bin/bash

set -eo pipefail

# Check if the user has proper privilegies to execute the script
# if [[ "$(/usr/bin/id -u)" -ne 0 ]]; then
#     echo "Please, execute the script as root or with sudo."
#     exit 1
# fi

# Verify if Docker is installed
if ! command -v docker &> /dev/null; then
    echo "Docker could not be found. Please, install it at https://docs.docker.com/engine/install/ and execute the script again."
fi

# Move to the script path
SCRIPT_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
cd "$SCRIPT_PATH"

# Install Kind
echo -e "
- Installing Kind and creating a new local cluster 
"
curl -Lo /tmp/kind https://kind.sigs.k8s.io/dl/v0.11.1/kind-linux-amd64
chmod +x /tmp/kind
/tmp/kind create cluster --config cluster.yaml
# At this point, Kind should sucessfully set the context to kind-kind

# Install the Ambassor ingress controller
echo -e "
- Applying Ambassor Ingress Controller
"
kubectl apply -f https://github.com/datawire/ambassador-operator/releases/latest/download/ambassador-operator-crds.yaml
kubectl apply -n ambassador -f https://github.com/datawire/ambassador-operator/releases/latest/download/ambassador-operator-kind.yaml
kubectl wait --timeout=180s -n ambassador --for=condition=deployed ambassadorinstallations/ambassador

# Create the 'app' namespace
if [[ ! "$(kubectl get namespace app | grep "Active")" ]]; then
echo -e "
- Creating the 'app' namespace
"
  kubectl apply -f namespace.yaml
fi

# Apply Kubernetes resources for Auth app
echo -e "
- Applying the 'auth' resources
"
kubectl apply -f auth

# Apply Kubernetes resources for Feed app
echo -e "
- Applying the 'feed' resources
"
kubectl apply -f feed
