#!/bin/bash

#================================================#
#            Set Variables                       #
#================================================#

export STATE_FILE="control_plane/terraform.tfstate"


export TF_VAR_KONG_CLUSTER_CONTROL_PLANE=$(jq -r '.resources[] | select(.type == "konnect_gateway_control_plane") | .instances[0].attributes.config.control_plane_endpoint' "${STATE_FILE}" | sed -E 's|https?://([^/]+)|\1|')
export TF_VAR_KONG_CLUSTER_TELEMETRY_ENDPOINT=$(jq -r '.resources[] | select(.type == "konnect_gateway_control_plane") | .instances[0].attributes.config.telemetry_endpoint' "${STATE_FILE}" | sed -E 's|https?://([^/]+)|\1|')
export TF_VAR_KONG_CLUSTER_CERT=$(cat certs/cluster.crt)
export TF_VAR_KONG_CLUSTER_CERT_KEY=$(cat certs/cluster.key)

#================================================#
#            Destroy                             #
#================================================#

cd data_plane
terraform destroy -auto-approve

cd ../control_plane
terraform destroy -auto-approve