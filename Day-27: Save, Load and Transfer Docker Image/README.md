# Docker Image Transfer Guide

## Overview
This guide provides step-by-step instructions to transfer a Docker image (`news:nautilus`) from **App Server 1** to **App Server 3** in the Stratos Data Center.

## Prerequisites
- SSH access to both App Server 1 and App Server 3
- Sudo privileges on both servers
- Docker installed on both servers
- Network connectivity between servers
- Sufficient disk space for the image archive

## Objective
Transfer the custom Docker image `news:nautilus` from App Server 1 to App Server 3 while maintaining the same image name and tag.

---

## Step-by-Step Instructions

### Step 1: Save Docker Image on App Server 1

Connect to App Server 1 and save the image as a tar archive.

```bash
# SSH into App Server 1
ssh user@app-server-1

# Check Docker service status
sudo systemctl status docker

# Start Docker if it's not running
sudo systemctl start docker

# Enable Docker to start on boot (optional)
sudo systemctl enable docker

# Verify the image exists
sudo docker images | grep news

# Save the image to a tar archive
sudo docker save -o /tmp/news-nautilus.tar news:nautilus

# Verify the archive was created and check its size
ls -lh /tmp/news-nautilus.tar
```

**Expected Output:**
```
-rw------- 1 root root 150M Nov 11 10:30 /tmp/news-nautilus.tar
```

---

### Step 2: Transfer Image Archive to App Server 3

Choose one of the following methods to transfer the archive:

#### Method A: Direct SCP Transfer (Recommended)

```bash
# From App Server 1, transfer directly to App Server 3
sudo scp /tmp/news-nautilus.tar user@app-server-3:/tmp/
```

#### Method B: Via Jump Server/Local Machine

```bash
# Step 1: Copy from App Server 1 to local machine
scp user@app-server-1:/tmp/news-nautilus.tar .

# Step 2: Copy from local machine to App Server 3
scp news-nautilus.tar user@app-server-3:/tmp/
```

#### Method C: Using rsync (For large images)

```bash
# More efficient for large files with progress display
sudo rsync -avzP /tmp/news-nautilus.tar user@app-server-3:/tmp/
```

---

### Step 3: Load Image on App Server 3

Connect to App Server 3 and load the Docker image.

```bash
# SSH into App Server 3
ssh user@app-server-3

# Check Docker service status
sudo systemctl status docker

# Start Docker if it's not running
sudo systemctl start docker

# Enable Docker to start on boot (optional)
sudo systemctl enable docker

# Load the image from the archive
sudo docker load -i /tmp/news-nautilus.tar

# Verify the image is loaded correctly
sudo docker images | grep news
```

**Expected Output:**
```
REPOSITORY   TAG        IMAGE ID       CREATED        SIZE
news         nautilus   abc123def456   2 days ago     150MB
```

---

### Step 4: Verification

Confirm the image is properly loaded on App Server 3.

```bash
# View detailed image information
sudo docker images news:nautilus

# Inspect the image metadata
sudo docker inspect news:nautilus

# Optional: Test run a container from the image
sudo docker run --rm news:nautilus echo "Image loaded successfully"
```

---

### Step 5: Cleanup (Optional)

Remove the tar archive to free up disk space.

```bash
# On App Server 1
sudo rm /tmp/news-nautilus.tar

# On App Server 3
sudo rm /tmp/news-nautilus.tar
```

---

## Automated Script

For convenience, you can use this automated script:

```bash
#!/bin/bash

# Configuration
SERVER1_USER="user"
SERVER1_HOST="app-server-1"
SERVER3_USER="user"
SERVER3_HOST="app-server-3"
IMAGE_NAME="news:nautilus"
ARCHIVE_NAME="news-nautilus.tar"

echo "=========================================="
echo "Docker Image Transfer Script"
echo "=========================================="

# Step 1: Save image on App Server 1
echo ""
echo "[1/4] Saving image on App Server 1..."
ssh ${SERVER1_USER}@${SERVER1_HOST} << EOF
sudo systemctl start docker
sudo docker save -o /tmp/${ARCHIVE_NAME} ${IMAGE_NAME}
echo "Image saved successfully: /tmp/${ARCHIVE_NAME}"
ls -lh /tmp/${ARCHIVE_NAME}
EOF

# Step 2: Transfer to App Server 3
echo ""
echo "[2/4] Transferring image to App Server 3..."
ssh ${SERVER1_USER}@${SERVER1_HOST} "sudo chmod 644 /tmp/${ARCHIVE_NAME}"
scp ${SERVER1_USER}@${SERVER1_HOST}:/tmp/${ARCHIVE_NAME} /tmp/
scp /tmp/${ARCHIVE_NAME} ${SERVER3_USER}@${SERVER3_HOST}:/tmp/

# Step 3: Load image on App Server 3
echo ""
echo "[3/4] Loading image on App Server 3..."
ssh ${SERVER3_USER}@${SERVER3_HOST} << EOF
sudo systemctl start docker
sudo docker load -i /tmp/${ARCHIVE_NAME}
echo "Image loaded successfully"
sudo docker images | grep news
EOF

# Step 4: Cleanup
echo ""
echo "[4/4] Cleaning up temporary files..."
ssh ${SERVER1_USER}@${SERVER1_HOST} "sudo rm /tmp/${ARCHIVE_NAME}"
ssh ${SERVER3_USER}@${SERVER3_HOST} "sudo rm /tmp/${ARCHIVE_NAME}"
rm /tmp/${ARCHIVE_NAME}

echo ""
echo "=========================================="
echo "Transfer completed successfully!"
echo "=========================================="
```

**Usage:**
```bash
# Make the script executable
chmod +x transfer-docker-image.sh

# Run the script
./transfer-docker-image.sh
```

---

## Troubleshooting

### Issue 1: Docker service not running

**Error:**
```
Cannot connect to the Docker daemon
```

**Solution:**
```bash
sudo systemctl start docker
sudo systemctl status docker
```

### Issue 2: Permission denied

**Error:**
```
Permission denied while trying to connect to the Docker daemon socket
```

**Solution:**
```bash
# Add user to docker group
sudo usermod -aG docker $USER

# Or use sudo for docker commands
sudo docker images
```

### Issue 3: Image not found

**Error:**
```
Error response from daemon: No such image: news:nautilus
```

**Solution:**
```bash
# List all images to verify the exact name
sudo docker images

# Check for the image with different tags
sudo docker images news
```

### Issue 4: Insufficient disk space

**Error:**
```
No space left on device
```

**Solution:**
```bash
# Check disk space
df -h

# Clean up unused Docker resources
sudo docker system prune -a

# Remove unused images
sudo docker image prune -a
```

### Issue 5: SSH connection issues

**Error:**
```
Connection refused or timeout
```

**Solution:**
```bash
# Verify SSH connectivity
ping app-server-3

# Test SSH connection
ssh -v user@app-server-3

# Check SSH service
sudo systemctl status sshd
```

---

## Important Notes

1. **Disk Space**: Ensure both servers have at least 2x the image size in available disk space
2. **Network Speed**: Transfer time depends on image size and network bandwidth
3. **Image Integrity**: The `docker save` and `docker load` commands preserve all image layers and metadata
4. **Security**: Use secure file transfer methods and clean up temporary files after transfer
5. **Docker Service**: Always ensure Docker service is running before executing Docker commands
6. **Backup**: Consider keeping a backup of the image archive before cleanup

---

## Command Reference

| Command | Description |
|---------|-------------|
| `docker save -o <file> <image>` | Save image to tar archive |
| `docker load -i <file>` | Load image from tar archive |
| `docker images` | List all Docker images |
| `docker inspect <image>` | Display detailed image information |
| `systemctl start docker` | Start Docker service |
| `systemctl status docker` | Check Docker service status |

---

## Additional Resources

- [Docker Save Documentation](https://docs.docker.com/engine/reference/commandline/save/)
- [Docker Load Documentation](https://docs.docker.com/engine/reference/commandline/load/)
- [Docker Image Management](https://docs.docker.com/engine/reference/commandline/image/)

---

## Support

For issues or questions, contact the DevOps team at Stratos DC.

**Last Updated:** November 11, 2025
