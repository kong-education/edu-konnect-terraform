# Konnect Terraform Setup

This project automates the setup of a Konnect Control plane and a docker data plane using Terraform.

## Prerequisites

Before you begin, ensure you have the following installed:
- Docker
- Terraform

Additionally, you will need a personal access token from Konnect.

## Configuration

Set up your environment variables with your Konnect credentials and the API endpoint:

1. **Personal Access Token**
    ```bash
    export TF_VAR_KONNECT_PAT="<PAT_HERE>"
    ```

2. **Konnect API Endpoint**
    ```bash
    export TF_VAR_KONNECT_API="<API_HERE>"
    ```
    ##### Example:
    ```bash
    export TF_VAR_KONNECT_API="https://us.api.konghq.com"
    ```

## Usage

To deploy your infrastructure, follow these steps:

#### Deployment

Run the following script to destroy the deployment:
```bash
./deploy.sh
```

#### Destroy
Run the following script to start the deployment:

```bash
./destroy.sh
```