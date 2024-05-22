// GCP project where we create the VM
project = ""
// Region where we create the VM
region = "us-central1"
// Zone where we create the VM
zone = "us-central1-a"
// Network where we create the VM
network = ""
// Sub-Network where we create the VM
subnetwork = ""
// Firewall tags to apply to the firewall. Default is "http-server" and "https-server"
firewall_tags = [""]
// The service account json file
service_account_json_file_path = ""

// The OpenAI API Key used to authenticate with OpenAI
openai_api_key = ""
// The OpenAI endpoint URL
openai_endpoint = ""

// Source IP ranges that are allowed to access the VM
source_ranges = [""]

// List of volumes you want to mount the files from. Example variable:
// gcnv_volumes = [
//   "1.2.3.4:/volume1",
//   "5.6.7.8:/volume2"
// ]

gcnv_volumes = []
ontap_volumes = []
