# Docker Nginx Container Setup - Nautilus DevOps

## Overview
This document provides instructions for setting up an nginx container on App Server 3 in Stratos DC as part of the containerization migration initiative.

## Prerequisites
- Docker installed and running on App Server 3
- Sudo/root access to the server
- Sample file (`sample.txt`) present in `/tmp` directory

## Requirements
The container setup must meet the following specifications:
- **Image**: nginx (latest tag preferred)
- **Container Name**: apps
- **Volume Mapping**: Host `/opt/devops` → Container `/home`
- **State**: Container must remain in running state
- **File**: Copy `/tmp/sample.txt` to `/opt/devops`

## Installation Steps

### Step 1: Pull the Nginx Image
```bash
docker pull nginx:latest
```

**Expected Output:**
```
latest: Pulling from library/nginx
Digest: sha256:...
Status: Downloaded newer image for nginx:latest
```

### Step 2: Prepare Host Directory and File
```bash
# Create the host directory
sudo mkdir -p /opt/devops

# Copy the sample file
sudo cp /tmp/sample.txt /opt/devops/

# Verify the file exists
ls -la /opt/devops/
```

### Step 3: Create and Run the Container
```bash
docker run -d \
  --name apps \
  -v /opt/devops:/home \
  nginx:latest
```

**Command Breakdown:**
- `-d` - Run container in detached mode (background)
- `--name apps` - Assign container name as "apps"
- `-v /opt/devops:/home` - Mount host directory to container
- `nginx:latest` - Use the nginx latest image

### Step 4: Verify the Setup
```bash
# Check if container is running
docker ps

# Verify file is accessible inside container
docker exec apps ls -la /home/

# View file contents
docker exec apps cat /home/sample.txt
```

## Quick Setup Script
For convenience, here's a complete script:

```bash
#!/bin/bash

echo "=== Docker Nginx Container Setup ==="

# Pull nginx image
echo "Pulling nginx image..."
docker pull nginx:latest

# Prepare host directory
echo "Creating host directory..."
sudo mkdir -p /opt/devops

# Copy sample file
echo "Copying sample file..."
sudo cp /tmp/sample.txt /opt/devops/

# Run container
echo "Starting container..."
docker run -d --name apps -v /opt/devops:/home nginx:latest

# Verify setup
echo "Verifying setup..."
docker ps | grep apps

echo "Listing files in container..."
docker exec apps ls -la /home/

echo "=== Setup Complete ==="
```

## Verification Checklist
- [ ] Nginx image pulled successfully
- [ ] `/opt/devops` directory created
- [ ] `sample.txt` copied to `/opt/devops`
- [ ] Container "apps" is running
- [ ] File visible inside container at `/home/sample.txt`

## Common Operations

### Check Container Status
```bash
docker ps -a | grep apps
```

### View Container Logs
```bash
docker logs apps
```

### Access Container Shell
```bash
docker exec -it apps /bin/bash
```

### Stop Container
```bash
docker stop apps
```

### Start Container
```bash
docker start apps
```

### Restart Container
```bash
docker restart apps
```

### Remove Container
```bash
docker stop apps
docker rm apps
```

## Troubleshooting

### Container Not Running
```bash
# Check container status
docker ps -a | grep apps

# View logs for errors
docker logs apps

# Restart container
docker restart apps
```

### File Not Found in Container
```bash
# Verify file exists on host
ls -la /opt/devops/sample.txt

# Check volume mount
docker inspect apps | grep -A 10 Mounts
```

### Permission Issues
```bash
# Ensure proper permissions on host directory
sudo chmod 755 /opt/devops
sudo ls -la /opt/devops/
```

### Port Conflicts (if accessing nginx web server)
```bash
# If you need to access nginx, add port mapping
docker stop apps
docker rm apps
docker run -d --name apps -p 8080:80 -v /opt/devops:/home nginx:latest
```

## Volume Mapping Details
| Host Path | Container Path | Description |
|-----------|----------------|-------------|
| `/opt/devops` | `/home` | Shared directory for data persistence |

**Note**: Any files added to `/opt/devops` on the host will be immediately available at `/home` in the container, and vice versa.

## Testing the Setup

### Test 1: Container Running
```bash
docker ps | grep apps
# Expected: Container "apps" should be listed with status "Up"
```

### Test 2: Volume Mount
```bash
docker exec apps ls /home/sample.txt
# Expected: /home/sample.txt
```

### Test 3: File Content
```bash
docker exec apps cat /home/sample.txt
# Expected: Content of sample.txt displayed
```

### Test 4: Write Test
```bash
# Create a test file from container
docker exec apps sh -c "echo 'Test from container' > /home/test.txt"

# Verify on host
cat /opt/devops/test.txt
# Expected: "Test from container"
```

## Additional Notes
- The nginx container will remain running as nginx runs as a foreground process
- The container will automatically restart on server reboot if configured with `--restart` flag
- Volume data persists even if the container is removed
- For production use, consider using named volumes instead of bind mounts

## References
- [Docker Documentation](https://docs.docker.com/)
- [Nginx Docker Image](https://hub.docker.com/_/nginx)
- [Docker Volume Documentation](https://docs.docker.com/storage/volumes/)

## Author
Nautilus DevOps Team

## Last Updated
November 4, 202
