variable "subscription" {
  description = "The Azure subscription where the resources will be created"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group to use"
  type        = string
}

variable "location" {
  description = "The Azure location where the resources will be created"
  type        = string
}

variable "vnet" {
  description = "The Azure vnet where the resources will be created"
  type        = string
}

variable "subnetid" {
  description = "The Azure subnet where the resources will be created"
  type        = string
}

variable "admin_username" {
  description = "The admin username used to log into the VM"
  type        = string
}

variable "admin_password" {
  description = "The admin password used to log into the VM"
  type        = string
}

variable "admin_ssh_key_file_location" {
  description = "Path to the public key to use for VM access"
  type        = string
}

variable "openai_api_key" {
  description = "API key used to talk to OPENAI"
  type        = string
}

variable "openai_endpoint" {
  description = "The endpoint used to talk to OPENAI"
  type        = string
}

variable "google_service_account_file_path" {
  description = "Path to Google service account JSON that has access to VertexAI"
  type        = string
}

variable "google_project" {
  description = "Project to use with Gemini"
  type = string
}

variable "google_region" {
  description = "Region to use with Gemini"
  type = string
}

variable "google_api_key" {
  description = "API key for Google"
  type = string
}

variable "google_ai_endpoint" {
  description = "Endpoint for Gemini"
  type = string
}

variable "source_ip_range" {
  description = "Source IP CIDR that the toolkit will be accessible from (your source IP for instance)"
  type        = string
}

variable "anf_volumes" {
  description = "ANF volumes to mount"
  type        = list(string)
}

variable "ontap_volumes" {
  description = "ONTAP volumes to mount"
  type        = list(string)
}
