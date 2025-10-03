#!/bin/bash
# DevOps 365 Days - Day 57: Docker Container Troubleshooting Commands

echo "=== Day 57: Docker Container Troubleshooting ==="

# Connect to App Server 1
echo "1. Connecting to App Server 1..."
ssh tony@stapp01

# Check container status
echo "2. Checking container status..."
docker ps -a

# Inspect volume mapping
echo "3. Verifying volume mapping..."
docker inspect nautilus | grep -A5 "Mounts"

# Start the container
echo "4. Starting nautilus container..."
docker start nautilus

# Verify container is running
echo "5. Confirming container status..."
docker ps

# Test website accessibility
echo "6. Testing website accessibility..."
curl http://localhost:8080/

# Verify content in host directory
echo "7. Checking host content..."
ls -la /var/www/html/

# Verify content in container
echo "8. Checking container content..."
docker exec nautilus ls -la /usr/local/apache2/htdocs/

# Check container logs
echo "9. Reviewing container logs..."
docker logs nautilus

# Verify Apache configuration
echo "10. Checking Apache configuration..."
docker exec nautilus apachectl configtest

echo "=== Troubleshooting Complete! ==="
