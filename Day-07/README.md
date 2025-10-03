
# DevOps 365 Days - Day 57: Docker Container Troubleshooting

## 🎯 Challenge Overview

Investigated and resolved a static website issue in a Docker container named `nautilus` running on App Server 1.

## 🚨 Problem Statement

An issue arose with a static website running in a container named `nautilus` on App Server 1. To resolve the issue, I needed to:

1. Check if the container's volume `/usr/local/apache2/htdocs` is correctly mapped with the host's volume `/var/www/html`
2. Verify that the website is accessible on host port 8080 on App Server 1
3. Confirm that the command `curl http://localhost:8080/` works on App Server 1

## 🔧 Solution Steps

### Step 1: Initial Investigation
```bash
# Connect to App Server 1
ssh tony@stapp01

# Check container status
docker ps -a
```
**Finding**: Container was in "Exited" status

### Step 2: Verify Volume Mapping
```bash
# Inspect container volume configuration
docker inspect nautilus | grep -A5 "Mounts"
```
**Result**: Volume mapping was correctly configured
- Host: `/var/www/html`
- Container: `/usr/local/apache2/htdocs`

### Step 3: Resolution
```bash
# Start the container
docker start nautilus

# Verify container is running
docker ps
```
**Result**: Container successfully started with port mapping 0.0.0.0:8080->80/tcp

### Step 4: Verification
```bash
# Test website accessibility
curl http://localhost:8080/

# Verify content synchronization
ls -la /var/www/html/
docker exec nautilus ls -la /usr/local/apache2/htdocs/

# Check container logs
docker logs nautilus
```

## 📊 Key Findings

- **Root Cause**: Container was stopped (Exited status)
- **Volume Mapping**: ✅ Correctly configured and working
- **Website Status**: ✅ Successfully serving content (34 bytes, HTTP 200)
- **Port Configuration**: ✅ Properly mapped 8080 (host) → 80 (container)
- **Apache Status**: ✅ Running normally with "Syntax OK"

## 🎉 Verification Results

Apache access log confirmed successful requests:
```
172.12.0.1 - - [03/Oct/2025:18:44:40 +0000] "GET / HTTP/1.1" 200 34
```

## 📚 Lessons Learned

1. **Start with Status Check**: Always verify container status first using `docker ps -a`
2. **Systematic Approach**: Follow a logical troubleshooting sequence
3. **Log Analysis**: Apache access logs provide valuable debugging information
4. **Volume Verification**: Ensure volume mappings are correctly configured
5. **Port Confirmation**: Verify network port mappings are properly set up

## 🛠️ Technologies Used

- **Docker**: Container management and orchestration
- **Apache HTTP Server**: Web server configuration and troubleshooting
- **Volume Mounting**: Persistent data management
- **Network Port Mapping**: Container networking
- **Linux CLI**: Command-line troubleshooting tools

## 🏆 Challenge Outcome

✅ **Successfully Resolved**: The static website is now accessible on `http://localhost:8080/`
✅ **Volume Mapping Verified**: Host and container directories are properly synchronized
✅ **Container Running**: nautilus container is operational and serving content
✅ **Skills Enhanced**: Improved Docker troubleshooting and web server diagnostics

## 🔗 Related Commands Reference

```bash
# Container management
docker ps -a                    # List all containers
docker start <container>        # Start a container
docker inspect <container>      # Get container details
docker logs <container>         # View container logs

# Container execution
docker exec <container> <command>   # Execute command in container

# Web testing
curl http://localhost:8080/     # Test website accessibility
```

---
**Day 57 Complete!** 🚀 

*Building DevOps expertise one day at a time through hands-on troubleshooting and real-world scenarios.*

---

Would you like me to modify anything in this README or create additional files?
