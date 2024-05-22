variable "project" {
  description = "The GCP project to use"
  type        = string
}

variable "region" {
  description = "The region where the resources will be created"
  type        = string
}

variable "zone" {
  description = "The zone where the resources will be created"
  type        = string
}

variable "network" {
  description = "The network to use for the instance"
  type        = string 
}

variable "subnetwork" {
  description = "The subnetwork to use for the instance"
  type        = string
}

variable "firewall_tags" {
  description = "List of tags to apply to the firewall rules"
  type        = list(string)
  default     = ["http-server", "https-server"]
}

variable "gcnv_volumes" {
  description = "List of GCNV NFS servers to mount"
  type        = list(string)
}

variable "ontap_volumes" {
  description = "List of ONTAP NFS servers to mount"
  type        = list(string)
}

variable "source_ranges" {
  description = "A list of source ranges"
  type        = list(string)
}

variable "service_account_json_file_path" {
  description = "Path to service account JSON for gcloud"
  type = string
}

variable "openai_api_key" {
  description = "API key for OpenAI"
  type = string
}

variable "openai_endpoint" {
  description = "Endpoint for OpenAI"
  type = string
}
