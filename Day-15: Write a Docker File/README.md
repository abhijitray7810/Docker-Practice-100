# Nautilus Application - Docker Image

## Overview
This repository contains the Dockerfile for building a custom Apache2 web server image for the Nautilus application project in Stratos DC. The image is based on Ubuntu 24.04 and configured to run Apache2 on port 3000.

## Prerequisites
- Docker installed on App Server 3
- Appropriate permissions to build and run Docker images
- Network access to pull the Ubuntu 24.04 base image

## Image Specifications

### Base Image
- **OS**: Ubuntu 24.04 (LTS)

### Installed Software
- **Web Server**: Apache2
- **Port Configuration**: Apache configured to listen on port 3000

### Configuration Details
- Apache2 runs on port 3000 instead of the default port 80
- All other Apache configuration settings remain at their defaults (including document root at `/var/www/html`)
- Apache runs in foreground mode for proper Docker container operation

## Installation & Deployment

### Step 1: Access App Server 3
```bash
ssh user@app-server-3
```

### Step 2: Verify Directory Structure
The Dockerfile is located at:
```
/opt/docker/Dockerfile
```

### Step 3: Build the Docker Image
Navigate to the directory and build the image:
```bash
cd /opt/docker
sudo docker build -t nautilus-app:latest .
```

You can also tag it with a version:
```bash
sudo docker build -t nautilus-app:v1.0 .
```

### Step 4: Run the Container
Start a container from the built image:
```bash
sudo docker run -d -p 3000:3000 --name nautilus-app nautilus-app:latest
```

**Command Breakdown:**
- `-d`: Run container in detached mode
- `-p 3000:3000`: Map host port 3000 to container port 3000
- `--name nautilus-app`: Assign a name to the container
- `nautilus-app:latest`: Image name and tag

## Verification & Testing

### Check Running Containers
```bash
sudo docker ps
```

### Test Apache Response
```bash
curl http://localhost:3000
```

You should see the default Apache2 Ubuntu page.

### View Container Logs
```bash
sudo docker logs nautilus-app
```

### Access Container Shell
```bash
sudo docker exec -it nautilus-app /bin/bash
```

## Container Management

### Stop the Container
```bash
sudo docker stop nautilus-app
```

### Start the Container
```bash
sudo docker start nautilus-app
```

### Restart the Container
```bash
sudo docker restart nautilus-app
```

### Remove the Container
```bash
sudo docker stop nautilus-app
sudo docker rm nautilus-app
```

### Remove the Image
```bash
sudo docker rmi nautilus-app:latest
```

## Customization

### Adding Custom Content
To serve custom web content, you can mount a volume:
```bash
sudo docker run -d -p 3000:3000 \
  -v /path/to/your/content:/var/www/html \
  --name nautilus-app \
  nautilus-app:latest
```

### Environment Variables
The Dockerfile sets `DEBIAN_FRONTEND=noninteractive` to prevent interactive prompts during package installation.

## Troubleshooting

### Port Already in Use
If port 3000 is already occupied:
```bash
# Check what's using port 3000
sudo netstat -tulpn | grep 3000
# or
sudo lsof -i :3000
```

### Container Won't Start
Check logs for errors:
```bash
sudo docker logs nautilus-app
```

### Apache Configuration Issues
Access the container to inspect Apache configuration:
```bash
sudo docker exec -it nautilus-app /bin/bash
apache2ctl -t  # Test configuration syntax
```

## Project Information
- **Project**: Nautilus Application
- **Environment**: Stratos DC
- **Server**: App Server 3
- **Team**: DevOps Team

## Support
For issues or questions related to this Docker image, contact the Nautilus application development team or the DevOps team.

## Notes
- The image is optimized for development and testing purposes
- Apache runs in foreground mode to keep the container running
- Only port configuration has been modified; all other Apache defaults remain unchanged
- The image uses Ubuntu's official package repositories for Apache2 installation
## 👥 Contributors
- https://github.com/abhijitray7810/Docker-Practice-100/edit/main/Day-15%3A%20Write%20a%20Docker%20File/README.md — DevOps Implementation, Docker Configuration
- https://www.linkedin.com/in/abhijit-ray-336442295 — Support / Code Review

