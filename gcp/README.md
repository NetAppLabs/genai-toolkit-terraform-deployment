# GenAI Toolkit Terraform Deployment

This project uses Terraform to deploy NetApp's GenAI Toolkit to Google Cloud Platform (GCP). 

## Prerequisites

- Terraform installed
- Google Cloud SDK (gcloud) installed and authenticated

## Variables

The following variables are used in this Terraform deployment:

- `project`: The GCP project to use.
- `region`: The region where the resources will be created.
- `zone`: The zone where the resources will be created.
- `network`: The network to use for the instance.
- `subnetwork`: The subnetwork to use for the instance.
- `firewall_tags`: List of tags to apply to the firewall rules.
- `source_ranges`: A list of source ranges.
- `service_account_json_file_path`: Path to service account JSON for gcloud.
- `openai_api_key`: API key for OpenAI.
- `openai_endpoint`: Endpoint for OpenAI.
- `gcnv_volumes`: List of GCNV NFS volumes to mount.
- `ontap_volumes`: List of ONTAP NFS volumes to mount.

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
   project = "<project_id>"
   region = "<region>"
   zone = "<zone>"
   network = "<network>"
   subnetwork = "<subnetwork>"
   firewall_tags = ["http-server", "https-server"]
   source_ranges = ["<source_range1>", "<source_range2>"]
   service_account_json_file_path = "<service_account_json_file_path>"
   openai_api_key = "<openai_api_key>"
   openai_endpoint = "<openai_endpoint>"
   gcnv_volumes = ["<1.2.3.4:/gcnv/volume1>", "<1.2.3.4:/gcnv/volume2>"]
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
