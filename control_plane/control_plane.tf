# Don't forget to create auth.tf to configure the provider
# (see examples/scenarios/_auth.tf for an example)

# Create a new Control Plane
resource "konnect_gateway_control_plane" "tfcp" {
  name         = "Terraform Control Plane"
  description  = "Control Plane created with Terraform"
  cluster_type = "CLUSTER_TYPE_HYBRID"
  auth_type    = "pinned_client_certs"

  proxy_urls = [
    {
      host     = "localhost",
      port     = 8000,
      protocol = "http"
    }
  ]
}

# Add data plane client certificate
resource "konnect_gateway_data_plane_client_certificate" "my_cert" {
  cert             = file("../certs/cluster.crt")
  control_plane_id = konnect_gateway_control_plane.tfcp.id
}

