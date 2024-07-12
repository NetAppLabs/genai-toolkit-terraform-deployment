# GenAI Toolkit Terraform Deployment

This project uses Terraform to deploy NetApp's GenAI Toolkit to Azure. 

## Prerequisites

- Terraform installed
- Azure CLI installed and authenticated

## Variables

The following variables are used in this Terraform deployment:

- `subscription`: The Azure subscription where the resources will be created.
- `resource_group_name`: The name of the resource group to use.
- `location`: The Azure location where the resources will be created.
- `vnet`: The Azure vnet where the resources will be created. Note that the VM will have to have network access to the volumes to use
- `subnetid`: The Azure subnet where the resources will be created.
- `admin_username`: The admin username used to log into the VM.
- `admin_password`: The admin password used to log into the VM.
- `admin_ssh_key_file_location`: Path to the public key to use for VM access.
- `source_ip_range`: Source IP CIDR that the toolkit will be accessible from (your source IP for instance).
- `anf_volumes`: List of ANF volumes to mount.
- `ontap_volumes`: List of ONTAP volumes to mount.

## Deployment Steps

1. Clone this repository and navigate to the Terraform directory.

   ```bash
   git clone <repository_url>
   cd <terraform_directory>
   ```
2. Initialize Terraform

   ```bash
   terraform init
   ```

3. Edit the `terraform.tfvars` file and specify the values for the variables. Here is an example:

   ```bash
   subscription = "<subscription_id>"
   resource_group_name = "<resource_group_name>"
   location = "<location>"
   vnet = "<vnet>"
   subnetid = "<subnet_id>"
   admin_username = "<admin_username>"
   admin_password = "<admin_password>"
   admin_ssh_key_file_location = "<ssh_key_file_path>"
   source_ip_range = "<source_ip_range>"
   anf_volumes = ["<1.2.3.4:/anf/volume1>", "<1.2.3.4:/anf/volume2>"]
   ontap_volumes = ["<1.2.3.4:/ontap/volume1>", "<1.2.3.4:/ontap/volume2>"]
   ```
   Replace the placeholders with your actual values.


4. Plan the Terraform deployment to see what resources will be created.

   ```bash
   terraform plan
   ```

5. Apply the Terraform deployment to create the resources.

   ```bash
   terraform apply
   ```
   Confirm the deployment by typing `yes` when prompted
