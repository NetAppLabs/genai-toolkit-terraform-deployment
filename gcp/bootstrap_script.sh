#!/bin/bash

apt-get update
apt-get install -y nfs-common apt-transport-https ca-certificates curl gnupg2 software-properties-common
add-apt-repository -y "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable"
curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -
apt-get update
apt-get install -y docker-ce
curl -L "https://github.com/docker/compose/releases/download/1.27.4/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

mkdir -p /volumes/
mkdir -p /databases/chromadb
mkdir -p /databases/postgres
mkdir -p /cache/api

#GCNV volume mount
IFS=',' read -ra nfs_servers <<< "$GCNV_VOLUMES"
for nfs_server in "${nfs_servers[@]}"; do
  volumename=${nfs_server##*/}
  mkdir -p /volumes/gcnv/$volumename
  mount -t nfs -o rw,hard,rsize=65536,wsize=65536,vers=3,tcp $nfs_server /volumes/gcnv/$volumename >> /tmp/startup.log 2>&1
done

#ONTAP volume mount
IFS=',' read -ra nfs_servers <<< "$ONTAP_VOLUMES"
for nfs_server in "${nfs_servers[@]}"; do
  volumename=${nfs_server##*/}
  mkdir -p /volumes/ontap/$volumename
  mount -t nfs -o rw,hard,rsize=65536,wsize=65536,vers=3,tcp $nfs_server /volumes/ontap/$volumename >> /tmp/startup.log 2>&1
done

sh -c 'curl -H "Metadata-Flavor: Google" http://metadata.google.internal/computeMetadata/v1/instance/attributes/service-account-credentials > /root/credentials.json'

cd /root/
docker compose up --detach --build --remove-orphans
