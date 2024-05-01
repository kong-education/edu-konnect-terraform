#!/bin/bash
#================================================#
#            Create Control Plane                #
#================================================#

# Initialize the control plane
cd control_plane
echo "Initializing the control plane"
terraform init

# Apply the control plane
echo "Applying the control plane"
terraform apply -auto-approve


#================================================#
#            Set Variables                       #
#================================================#

cd ..
export STATE_FILE="control_plane/terraform.tfstate"


export TF_VAR_KONG_CLUSTER_CONTROL_PLANE=$(jq -r '.resources[] | select(.type == "konnect_gateway_control_plane") | .instances[0].attributes.config.control_plane_endpoint' "${STATE_FILE}" | sed -E 's|https?://([^/]+)|\1|')
export TF_VAR_KONG_CLUSTER_TELEMETRY_ENDPOINT=$(jq -r '.resources[] | select(.type == "konnect_gateway_control_plane") | .instances[0].attributes.config.telemetry_endpoint' "${STATE_FILE}" | sed -E 's|https?://([^/]+)|\1|')
export TF_VAR_KONG_CLUSTER_CERT=$(cat certs/cluster.crt)
export TF_VAR_KONG_CLUSTER_CERT_KEY=$(cat certs/cluster.key)

echo $TF_VAR_KONG_CLUSTER_CONTROL_PLANE
echo $TF_VAR_KONG_CLUSTER_TELEMETRY_ENDPOINT
echo $TF_VAR_KONG_CLUSTER_CERT
echo $TF_VAR_KONG_CLUSTER_CERT_KEY
#================================================#
#            Create Data Plane                   #
#================================================#

cd data_plane
echo "Initializing the data plane"
terraform init
echo "Applying the data plane"
terraform apply -auto-approve
cd ..


