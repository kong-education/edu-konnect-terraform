terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.1"
    }
  }
}

variable "KONG_CLUSTER_CONTROL_PLANE" {
  type        = string
  description = "The Kong cluster control plane address"
}

variable "KONG_CLUSTER_TELEMETRY_ENDPOINT" {
  type        = string
  description = "The Kong telemetry endpoint address"
}

variable "KONG_CLUSTER_CERT" {
  type        = string
  description = "Path to Kong cluster certificate"
}

variable "KONG_CLUSTER_CERT_KEY" {
  type        = string
  description = "Path to Kong cluster certificate key"
}


provider "docker" {}

resource "docker_image" "kong" {
  name         = "docker.io/kong/kong-gateway:3.4"
  keep_locally = true
}

resource "docker_container" "konnect-dp" {
  image = docker_image.kong.image_id
  name  = "konnect-dp"

  ports {
    internal = 8000
    external = 8000
  }
  env = [
    "KONG_ROLE=data_plane",
    "KONG_DATABASE=off",
    "KONG_CLUSTER_MTLS=pki",
    "KONG_VITALS=off",
    "KONG_CLUSTER_CONTROL_PLANE=${var.KONG_CLUSTER_CONTROL_PLANE}:443",
    "KONG_CLUSTER_SERVER_NAME=${var.KONG_CLUSTER_CONTROL_PLANE}",
    "KONG_CLUSTER_TELEMETRY_ENDPOINT=${var.KONG_CLUSTER_TELEMETRY_ENDPOINT}:443",
    "KONG_CLUSTER_TELEMETRY_SERVER_NAME=${var.KONG_CLUSTER_TELEMETRY_ENDPOINT}",
    "KONG_CLUSTER_CERT=${var.KONG_CLUSTER_CERT}",
    "KONG_CLUSTER_CERT_KEY=${var.KONG_CLUSTER_CERT_KEY}",
    "KONG_LUA_SSL_TRUSTED_CERTIFICATE=system",
    "KONG_KONNECT_MODE=on",
    "KONG_CLUSTER_DP_LABELS=created-by:terraform,type:docker-local"
  ]
}

