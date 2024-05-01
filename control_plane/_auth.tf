# Configure the provider to use your Kong Konnect account
terraform {
  required_providers {
    konnect = {
      source  = "kong/konnect"
      version = "0.2.1"
    }
  }
}

variable "KONNECT_PAT" {
  description = "Personal access token for Konnect provider"
  type        = string
  sensitive   = true  # Marks the variable as sensitive, hiding its value in CLI output
}

variable "KONNECT_API" {
  description = "Konnect API base URL"
  type        = string
  sensitive   = false
}
provider "konnect" {
  personal_access_token = var.KONNECT_PAT
  server_url            = var.KONNECT_API
}
