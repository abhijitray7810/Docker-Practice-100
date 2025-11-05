# Nginx Container Setup on Application Server 3

## Overview
This document provides instructions for setting up an nginx-based container on Application Server 3 in the Stratos Datacenter.

## Task Requirements
- **Server**: Application Server 3
- **Image**: nginx:alpine
- **Container Name**: apps
- **Port Mapping**: Host port 5002 → Container port 80
- **State**: Running

---

## Setup Instructions

### Step 1: Pull the Docker Image
```bash
sudo docker pull nginx:alpine
```

### Step 2: Verify Image Download
```bash
sudo docker images nginx:alpine
```

**Expected Output:**
```
REPOSITORY   TAG       IMAGE ID       CREATED        SIZE
nginx        alpine    <image-id>     <time-ago>     ~40MB
```

### Step 3: Create and Run the Container
```bash
sudo docker run -d --name apps -p 5002:80 nginx:alpine
```

**Command Parameters:**
- `-d` : Run in detached mode (background)
- `--name apps` : Assign container name "apps"
- `-p 5002:80` : Map host port 5002 to container port 80
- `nginx:alpine` : Use the nginx:alpine image

### Step 4: Verify Container Status
```bash
sudo docker ps
```

**Expected Output:**
```
CONTAINER ID   IMAGE          COMMAND                  STATUS         PORTS                    NAMES
<container-id> nginx:alpine   "/docker-entrypoint.…"   Up X seconds   0.0.0.0:5002->80/tcp    apps
```

### Step 5: Test the Nginx Server
```bash
curl http://localhost:5002
```

**Expected Output:** HTML content from nginx welcome page

---

## Verification Commands

### Check Container Status
```bash
# List all containers
sudo docker ps -a | grep apps

# Check container details
sudo docker inspect apps
```

### View Container Logs
```bash
sudo docker logs apps
```

### Check Port Binding
```bash
sudo netstat -tulpn | grep 5002
```

### Test from External Access
```bash
curl -I http://<server-ip>:5002
```

---

## Container Management

### Stop the Container
```bash
sudo docker stop apps
```

### Start the Container
```bash
sudo docker start apps
```

### Restart the Container
```bash
sudo docker restart apps
```

### Remove the Container
```bash
# Stop first if running
sudo docker stop apps

# Remove container
sudo docker rm apps
```

---

## Troubleshooting

### Issue: Port Already in Use
```bash
# Check what's using port 5002
sudo lsof -i :5002

# Kill the process if necessary
sudo kill <PID>
```

### Issue: Container Exits Immediately
```bash
# Check container logs
sudo docker logs apps

# Check container status
sudo docker ps -a | grep apps
```

### Issue: Cannot Access from External Network
- Verify firewall rules allow port 5002
- Check if the server IP is correct
- Ensure container is running: `sudo docker ps`

---

## Success Criteria
✅ nginx:alpine image pulled successfully  
✅ Container named "apps" created  
✅ Container is in running state  
✅ Port 5002 on host mapped to port 80 in container  
✅ Nginx welcome page accessible on http://localhost:5002  

---

## Notes
- The container will continue running until stopped manually
- The nginx:alpine image is lightweight (~40MB) and production-ready
- Container will automatically restart on server reboot if configured with `--restart` flag

## Additional Resources
- [Docker Documentation](https://docs.docker.com/)
- [Nginx Official Image](https://hub.docker.com/_/nginx)
- Stratos Datacenter DevOps Documentation
