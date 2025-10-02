# Nautilus DevOps Task - Copy Encrypted File to Container

This document describes the steps to install Docker, run the `ubuntu_latest` container, and copy an encrypted file from the Docker host into the container without modifying it.

---

## Prerequisites
- Access to **App Server 2** in Stratos Datacenter  
- Root or sudo privileges  
- Internet access for package installation  

---

## Steps

### 1. Install Docker

#### On CentOS/RHEL:
```bash
sudo yum install -y yum-utils
sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
sudo yum install -y docker-ce docker-ce-cli containerd.io
````

#### On Ubuntu/Debian:

```bash
sudo apt update -y
sudo apt install -y apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) stable"
sudo apt update -y
sudo apt install -y docker-ce docker-ce-cli containerd.io
```

---

### 2. Start and Enable Docker

```bash
sudo systemctl start docker
sudo systemctl enable docker
```

---

### 3. Run the `ubuntu_latest` Container

```bash
sudo docker run -dit --name ubuntu_latest ubuntu:latest
```

Verify container is running:

```bash
sudo docker ps
```

---

### 4. Copy Encrypted File into Container

Copy the file `/tmp/nautilus.txt.gpg` from the Docker host to `/opt/` inside the container:

```bash
sudo docker cp /tmp/nautilus.txt.gpg ubuntu_latest:/opt/
```

---

### 5. Verify File Inside Container

```bash
sudo docker exec -it ubuntu_latest ls -l /opt/
```

Expected output:

```
-rw-r--r-- 1 root root <size> nautilus.txt.gpg
```

---

## Notes

* The file remains **encrypted** and is copied **without modification**.
* Use `docker cp` for secure, bit-for-bit file transfers between host and container.
* Ensure the container is running before executing the copy command.

---

✅ **Task Completed Successfully**
