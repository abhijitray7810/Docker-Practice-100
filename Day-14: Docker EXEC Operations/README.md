# Apache2 Configuration on kkloud Container

## Overview
This document provides instructions for installing and configuring Apache2 web server on the `kkloud` container running on App Server 2 in Stratos Datacenter.

## Prerequisites
- Access to App Server 2 in Stratos Datacenter
- SSH credentials for App Server 2
- Docker installed and running on App Server 2
- `kkloud` container must be running
- Root or sudo privileges

## Task Requirements
1. Install `apache2` in the `kkloud` container using `apt`
2. Configure Apache to listen on port `8087` instead of default HTTP port (80)
3. Apache should listen on all interfaces (not bound to specific IP/hostname)
4. Ensure Apache service is running inside the container
5. Keep the container in running state

## Installation Steps

### Step 1: Connect to App Server 2
```bash
# SSH into App Server 2
ssh <username>@<app-server-2-hostname>
```

### Step 2: Verify kkloud Container is Running
```bash
# List running containers
docker ps | grep kkloud

# Expected output should show kkloud container with STATUS "Up"
```

### Step 3: Access the Container
```bash
# Enter the kkloud container
docker exec -it kkloud /bin/bash
```

### Step 4: Install Apache2
```bash
# Update package repository
apt update

# Install apache2
apt install apache2 -y
```

### Step 5: Configure Apache to Listen on Port 8087
```bash
# Modify ports.conf to change default port from 80 to 8087
sed -i 's/Listen 80/Listen 8087/g' /etc/apache2/ports.conf

# Update default virtual host configuration
sed -i 's/<VirtualHost \*:80>/<VirtualHost *:8087>/g' /etc/apache2/sites-available/000-default.conf
```

### Step 6: Start Apache Service
```bash
# Start Apache2 service
service apache2 start

# Verify service is running
service apache2 status
```

### Step 7: Verify Configuration
```bash
# Check Apache is listening on port 8087
netstat -tlnp | grep 8087
# OR
ss -tlnp | grep 8087

# Test Apache response
curl http://localhost:8087

# Expected output: Apache default HTML page
```

### Step 8: Exit Container
```bash
# Exit the container shell (keeps container running)
exit
```

## Quick Setup Script

For faster deployment, use this consolidated script from the Docker host:

```bash
docker exec -it kkloud bash -c "
apt update && \
apt install apache2 -y && \
sed -i 's/Listen 80/Listen 8087/g' /etc/apache2/ports.conf && \
sed -i 's/<VirtualHost \*:80>/<VirtualHost *:8087>/g' /etc/apache2/sites-available/000-default.conf && \
service apache2 start && \
service apache2 status
"
```

## Verification Commands

After installation, verify the setup:

```bash
# 1. Check container is running
docker ps | grep kkloud

# 2. Verify Apache service status
docker exec kkloud service apache2 status

# 3. Check Apache is listening on port 8087
docker exec kkloud netstat -tlnp | grep 8087

# 4. Test HTTP response
docker exec kkloud curl -I http://localhost:8087

# 5. Test from container IP (if known)
docker exec kkloud curl -I http://127.0.0.1:8087
```

## Configuration Files Modified

| File | Location | Changes |
|------|----------|---------|
| ports.conf | `/etc/apache2/ports.conf` | Changed `Listen 80` to `Listen 8087` |
| 000-default.conf | `/etc/apache2/sites-available/000-default.conf` | Changed `<VirtualHost *:80>` to `<VirtualHost *:8087>` |

## Important Notes

- ✅ Apache listens on **0.0.0.0:8087** (all interfaces)
- ✅ Not bound to specific IP or hostname
- ✅ Accessible via localhost, 127.0.0.1, and container IP
- ✅ Container remains in **running** state after configuration
- ⚠️ If the container restarts, Apache service may need to be started again (unless configured with init system)

## Troubleshooting

### Apache won't start
```bash
# Check Apache configuration syntax
docker exec kkloud apache2ctl configtest

# Check Apache error logs
docker exec kkloud tail -f /var/log/apache2/error.log
```

### Port 8087 already in use
```bash
# Check what's using the port
docker exec kkloud netstat -tlnp | grep 8087

# Kill the process if necessary
docker exec kkloud kill -9 <PID>
```

### Container stopped unexpectedly
```bash
# Start the container
docker start kkloud

# Start Apache inside container
docker exec kkloud service apache2 start
```

### Apache not responding
```bash
# Restart Apache service
docker exec kkloud service apache2 restart

# Check if port is listening
docker exec kkloud ss -tlnp | grep 8087
```

## Service Management

```bash
# Start Apache
docker exec kkloud service apache2 start

# Stop Apache
docker exec kkloud service apache2 stop

# Restart Apache
docker exec kkloud service apache2 restart

# Reload Apache (graceful restart)
docker exec kkloud service apache2 reload

# Check Apache status
docker exec kkloud service apache2 status
```

## Additional Resources

- [Apache HTTP Server Documentation](https://httpd.apache.org/docs/)
- [Docker Documentation](https://docs.docker.com/)
- [Apache Configuration Files](https://httpd.apache.org/docs/2.4/configuring.html)

## Completion Checklist

- [ ] Connected to App Server 2
- [ ] Verified kkloud container is running
- [ ] Installed apache2 using apt
- [ ] Configured Apache to listen on port 8087
- [ ] Updated ports.conf file
- [ ] Updated default virtual host configuration
- [ ] Started Apache service
- [ ] Verified Apache is listening on port 8087
- [ ] Tested HTTP response on port 8087
- [ ] Container remains in running state

## Author
Nautilus DevOps Team

## Date
October 18, 2025

---

**Status**: ✅ Configuration Complete
