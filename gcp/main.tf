provider "google" {
  credentials = file(var.service_account_json_file_path)
  project = var.project
  region  = var.region
  zone    = var.zone
}

resource "google_compute_instance" "genai-toolkit-vm" {
  provider = google
  name = "genai-toolkit-vm"
  machine_type = "e2-standard-4"
  network_interface {
    network = var.network
    subnetwork = var.subnetwork

    access_config {

    }
  }

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-12-bookworm-v20240213"
      size  = 100
    }
  }

  metadata_startup_script = <<SCRIPT
  #!/bin/bash
  set -x
  sudo apt-get update > /tmp/startup.log 2>&1
  sudo apt-get install -y ca-certificates curl >> /tmp/startup.log 2>&1
  sudo install -m 0755 -d /etc/apt/keyrings >> /tmp/startup.log 2>&1
  sudo curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc >> /tmp/startup.log 2>&1
  sudo chmod a+r /etc/apt/keyrings/docker.asc >> /tmp/startup.log 2>&1
  echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null >> /tmp/startup.log 2>&1
  sudo apt-get update >> /tmp/startup.log 2>&1
  sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin >> /tmp/startup.log 2>&1
  sudo apt-get install -y nfs-common >> /tmp/startup.log 2>&1
  sudo mkdir -p /volumes/ >> /tmp/startup.log 2>&1
  echo "Running mount command" >> /tmp/startup.log

  # Convert the list of NFS servers to a space-separated string
  gcnv_volumes="${join(" ", var.gcnv_volumes)}"
  ontap_volumes="${join(" ", var.ontap_volumes)}"

  #GCNV volume mount
  for nfs_server in $gcnv_volumes; do
    volumename=$${nfs_server##*/}
    sudo mkdir -p /volumes/gcnv/$volumename
    echo "Mounting $nfs_server at /volumes/gcnv/$volumename"
    sudo mount -t nfs -o rw,hard,rsize=65536,wsize=65536,vers=3,tcp $nfs_server /volumes/gcnv/$volumename >> /tmp/startup.log 2>&1
  done

  #ONTAP volume mount
  for nfs_server in $ontap_volumes; do
    volumename=$${nfs_server##*/}
    sudo mkdir -p /volumes/ontap/$volumename
    echo "Mounting $nfs_server at /volumes/ontap/$volumename"
    sudo mount -t nfs -o rw,hard,rsize=65536,wsize=65536,vers=3,tcp $nfs_server /volumes/ontap/$volumename >> /tmp/startup.log 2>&1
  done

  echo "Finished mounting volumes" >> /tmp/startup.log
  sudo docker pull us-central1-docker.pkg.dev/gcp-nv-1p-demos/genai2/genai-toolkit-ui &  >> /tmp/startup.log
  sudo docker pull us-central1-docker.pkg.dev/gcp-nv-1p-demos/genai2/genai-toolkit-api &  >> /tmp/startup.log
  sudo docker pull us-central1-docker.pkg.dev/gcp-nv-1p-demos/genai2/genai-toolkit-nginx &  >> /tmp/startup.log
  sudo docker pull us-central1-docker.pkg.dev/gcp-nv-1p-demos/genai2/chromadb/chroma &  >> /tmp/startup.log
  sudo docker pull us-central1-docker.pkg.dev/gcp-nv-1p-demos/genai2/postgres  >> /tmp/startup.log
  wait
  docker network create my-network
  echo "Running Docker Images" >> /tmp/startup.log
  INSTANCE_IP=$(curl -H "Metadata-Flavor: Google" http://metadata.google.internal/computeMetadata/v1/instance/network-interfaces/0/access-configs/0/external-ip)
  sudo docker run --name chromadb -p 8000:8000 --network=my-network -d us-central1-docker.pkg.dev/gcp-nv-1p-demos/genai2/chromadb/chroma
  sudo docker run --name postgres -p 5432:5432 --network=my-network -d -e POSTGRES_USER=admin -e POSTGRES_PASSWORD=admin us-central1-docker.pkg.dev/gcp-nv-1p-demos/genai2/postgres
  sudo docker run --name genai-toolkit-ui -p 3000:3000 --network=my-network -d -e GOOGLE_PROJECT_ID=${var.project} -e GOOGLE_API_KEY=${var.google_api_key} -e GOOGLE_REGION=${var.region} us-central1-docker.pkg.dev/gcp-nv-1p-demos/genai2/genai-toolkit-ui
  sudo docker run --name genai-toolkit-api -p 8001:8001 -d --network=my-network -v /volumes/gcnv:/root_dir/gcnv -v /volumes/ontap:/root_dir/ontap -e ROOT_DIR=/root_dir -e GOOGLE_PROJECT_ID=${var.project} -e CHROMA_HOST=chromadb -e POSTGRES_HOST=postgres -e POSTGRES_CONNECTIONSTRING=postgresql+psycopg2://admin:admin@postgres:5432/postgres -e POSTGRES_DB=postgres -e GOOGLE_API_KEY=${var.google_api_key} -e GOOGLE_REGION=${var.region} us-central1-docker.pkg.dev/gcp-nv-1p-demos/genai2/genai-toolkit-api
  sudo docker run --name nginx -p 443:443 -p 80:80 --network=my-network us-central1-docker.pkg.dev/gcp-nv-1p-demos/genai2/genai-toolkit-nginx
  echo "Done!" >> /tmp/startup.log
  SCRIPT

  tags = ["http-server", "https-server"]

  allow_stopping_for_update = true
}

resource "time_sleep" "wait_2_minutes" {
  depends_on = [google_compute_instance.genai-toolkit-vm]

  create_duration = "3m"
}

output "app_url" {
  value = format("http://%s", google_compute_instance.genai-toolkit-vm.network_interface[0].access_config[0].nat_ip)
  description = "The URL for accessing the toolkit."
  depends_on = [time_sleep.wait_2_minutes]
}
