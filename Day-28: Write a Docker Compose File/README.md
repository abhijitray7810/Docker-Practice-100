# HTTPD Web Server Container Setup

## Overview
This document provides instructions for deploying the Nautilus application's static website content using an Apache HTTP Server (httpd) container on App Server 2 in Stratos DC.

## Prerequisites
- Docker and Docker Compose installed on App Server 2
- Access to App Server 2 with sudo privileges
- `/opt/security` directory exists on the host with static website content

## Configuration Specifications

| Component | Value |
|-----------|-------|
| Container Name | `httpd` |
| Docker Image | `httpd:latest` |
| Host Port | `8086` |
| Container Port | `80` |
| Host Volume | `/opt/security` |
| Container Volume | `/usr/local/apache2/htdocs` |
| Compose File Location | `/opt/docker/docker-compose.yml` |

## Deployment Steps

### 1. Create Directory Structure
```bash
sudo mkdir -p /opt/docker
```

### 2. Create Docker Compose File
Create the file `/opt/docker/docker-compose.yml` with the provided configuration.

### 3. Deploy the Container
```bash
cd /opt/docker
sudo docker-compose up -d
```

### 4. Verify Deployment
```bash
# Check container status
sudo docker-compose ps

# Verify container is running
sudo docker ps | grep httpd

# Check container logs
sudo docker-compose logs httpd-service
```

### 5. Test the Web Server
```bash
# Test locally
curl http://localhost:8086

# Test from remote machine (replace with actual server IP)
curl http://<app-server-2-ip>:8086
```

## Docker Compose Commands

### Start the container
```bash
sudo docker-compose up -d
```

### Stop the container
```bash
sudo docker-compose down
```

### Restart the container
```bash
sudo docker-compose restart
```

### View logs
```bash
sudo docker-compose logs -f httpd-service
```

### Check container status
```bash
sudo docker-compose ps
```

## Troubleshooting

### Container won't start
```bash
# Check logs for errors
sudo docker-compose logs httpd-service

# Verify port is not already in use
sudo netstat -tlnp | grep 8086
sudo lsof -i :8086
```

### Permission issues
```bash
# Verify volume permissions
ls -la /opt/security

# Check SELinux context (if applicable)
ls -Z /opt/security
```

### Cannot access website
```bash
# Check if container is running
sudo docker ps | grep httpd

# Verify port mapping
sudo docker port httpd

# Check firewall rules
sudo firewall-cmd --list-ports
sudo iptables -L -n | grep 8086
```

### Volume mapping verification
```bash
# Inspect container volumes
sudo docker inspect httpd | grep -A 10 Mounts

# Check content inside container
sudo docker exec httpd ls -la /usr/local/apache2/htdocs
```

## Maintenance

### Update container image
```bash
cd /opt/docker
sudo docker-compose pull
sudo docker-compose up -d
```

### Backup configuration
```bash
sudo cp /opt/docker/docker-compose.yml /opt/docker/docker-compose.yml.backup
```

### Clean up
```bash
# Remove container (keeps volumes)
sudo docker-compose down

# Remove container and volumes
sudo docker-compose down -v
```

## Important Notes

- **Do not modify** any data within `/opt/security` or `/usr/local/apache2/htdocs` locations
- The container will automatically restart unless explicitly stopped
- Port `8086` on the host must be available and not blocked by firewall
- Ensure Docker daemon is running before executing commands

## Security Considerations

- Review and update the httpd image regularly for security patches
- Ensure appropriate file permissions on `/opt/security` directory
- Configure firewall rules to restrict access to port 8086 as needed
- Monitor container logs for suspicious activity

## Support

For issues or questions, contact the DevOps team or refer to:
- [Apache HTTP Server Documentation](https://httpd.apache.org/docs/)
- [Docker Compose Documentation](https://docs.docker.com/compose/)
- [Docker Hub - httpd Image](https://hub.docker.com/_/httpd)

## Revision History

| Date | Version | Description |
|------|---------|-------------|
| 2025-11-11 | 1.0 | Initial deployment documentation |
