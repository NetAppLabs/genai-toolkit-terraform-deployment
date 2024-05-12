# Terraform Deployment for NetApps GenAI toolkit

This terraform deployment deploys the NetApp GenAI toolkit for GCP.

## Prerequisites

1. [Terraform](https://www.terraform.io/downloads.html) installed on your machine.
2. A GCP account with necessary permissions to create resources.
2. Google Cloud Project
3. Service Account
4. Appropriate rules – IAM 
5. VPC Network
6. Firewall Rules to allow incoming traffic.
7. A GCP Service Account Key


## Variables

You need to provide values for the following variables either through the `terraform.tfvars` file or via command line:

- `project`: The ID of the project in which resources will be deployed.
- `region`: The region in which resources will be deployed.
- `zone`: The zone within the region for the deployment.
- `network`: The network to which the VM will be connected.
- `subnetwork`: The subnetwork within the network for the VM.
- `tags`: The tags to to the VM and firewall rules.
- `gcnv_volumes`: A list of GCNV NFS volumes (see variables files for more info)
- `ontap_volumes`: A list of ONTAP NFS volumes (see variables files for more info)

## Usage

1. A GCP Service Account key has to be set for authentication when deploying the terraform script from your local linux machine. The downloaded key can be set as an evironmental variable in the following manner.

```bash
export GOOGLE_APPLICATION_CREDENTIALS="/path/to/keyfile.json"

```

2. Initialize Terraform in the directory containing the Terraform files:

```bash
terraform init
```

3. Plan the deployment and review the resources that will be created:

```bash
terraform plan
```

4. Apply the Terraform configuration to create the resources:

```bash
terraform apply
```

## Firewall Rules

This script creates two firewall rules:

- `http_firewall`: Allows incoming HTTP traffic on port 80.
- `https_firewall`: Allows incoming HTTPS traffic on port 443.

## VM Configuration

The script deploys a VM named `genai-toolkit-vm` with the following configuration:

- Machine type: `e2-standard-4`
- Network: As per the `network` variable
- Subnetwork: As per the `subnetwork` variable
- Boot disk: Debian 12 with a size of 100 GB
- Startup script: Installs and sets up the toolkit
