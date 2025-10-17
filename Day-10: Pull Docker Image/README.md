# Nautilus Project - Docker Image Retagging Task

## Overview
This repository contains documentation for the Nautilus project containerized environment testing setup. The DevOps team has been tasked with preparing Docker images on App Server 2 in the Stratos DC.

## Project Details
**Project Name:** Nautilus Project  
**Environment:** Stratos Data Center  
**Target Server:** App Server 2  
**Objective:** Pull and retag Docker image for containerized application feature testing

## Task Requirements

### Objective
Pull the `busybox:musl` image and create a new tag `busybox:media` on App Server 2.

### Deliverables
- ✅ Pull `busybox:musl` image from Docker Hub
- ✅ Create new tag `busybox:media` from the pulled image
- ✅ Verify both tags exist on the server

## Implementation Guide

### Prerequisites
- SSH access to App Server 2 in Stratos DC
- Docker installed and running on the server
- Sufficient permissions to execute Docker commands
- Network connectivity to Docker Hub

### Step-by-Step Instructions

#### 1. Connect to App Server 2
```bash
ssh <username>@<app-server-2-hostname>
```

#### 2. Pull the Base Image
```bash
docker pull busybox:musl
```

**Expected Output:**
```
musl: Pulling from library/busybox
<hash>: Pull complete
Digest: sha256:...
Status: Downloaded newer image for busybox:musl
docker.io/library/busybox:musl
```

#### 3. Create New Tag
```bash
docker tag busybox:musl busybox:media
```

#### 4. Verify Results
```bash
docker images | grep busybox
```

**Expected Output:**
```
REPOSITORY    TAG      IMAGE ID       CREATED        SIZE
busybox       media    <image-id>     <date>         <size>
busybox       musl     <image-id>     <date>         <size>
```

### Quick Command Reference
```bash
# Complete task in one sequence
docker pull busybox:musl && \
docker tag busybox:musl busybox:media && \
docker images | grep busybox
```

### Using sudo (if required)
```bash
sudo docker pull busybox:musl && \
sudo docker tag busybox:musl busybox:media && \
sudo docker images | grep busybox
```

## Verification Checklist

- [ ] Successfully connected to App Server 2
- [ ] `busybox:musl` image pulled without errors
- [ ] `busybox:media` tag created successfully
- [ ] Both tags visible in `docker images` output
- [ ] Both tags have identical IMAGE ID
- [ ] No error messages during execution

## Troubleshooting

### Common Issues and Solutions

#### Permission Denied Error
```bash
# Solution: Use sudo or add user to docker group
sudo docker pull busybox:musl
# OR
sudo usermod -aG docker $USER
# (logout and login again)
```

#### Docker Service Not Running
```bash
# Check service status
sudo systemctl status docker

# Start Docker service
sudo systemctl start docker

# Enable Docker on boot
sudo systemctl enable docker
```

#### Network/Registry Connection Issues
```bash
# Test connectivity to Docker Hub
ping registry-1.docker.io

# Check Docker daemon
sudo docker info

# Try explicit registry pull
docker pull docker.io/library/busybox:musl
```

#### Image Pull Timeout
```bash
# Increase timeout and retry
docker pull --timeout 300 busybox:musl
```

## Technical Details

### About BusyBox
- **BusyBox** is a lightweight Unix utilities suite
- **musl variant** uses musl libc (minimal C standard library)
- **Size:** Typically ~1-2 MB
- **Use Case:** Minimal container images for testing and production

### Docker Tag Behavior
- Tagging creates an alias to the same image
- No additional disk space is consumed
- Same Image ID for all tags pointing to the same image
- Tags can be deleted independently

## Cleanup (Optional)

### Remove Single Tag
```bash
docker rmi busybox:media
```

### Remove Both Tags
```bash
docker rmi busybox:media busybox:musl
```

### Force Remove (if containers exist)
```bash
docker rmi -f busybox:media busybox:musl
```

## Project Context

This task is part of the Nautilus project's initiative to test containerized environment features. The DevOps team is preparing the infrastructure for:
- Container-based application deployment
- Feature testing in isolated environments
- Microservices architecture validation

## Contact & Support

For issues or questions regarding this task:
- Contact the DevOps team lead
- Refer to the Nautilus project documentation
- Check Stratos DC infrastructure guidelines

## Version History

| Version | Date | Description | Author |
|---------|------|-------------|---------|
| 1.0 | 2025-10-17 | Initial task documentation | DevOps Team |

## License

Internal use only - Nautilus Project / Stratos DC

---

**Status:** 📋 Documentation Complete  
**Next Steps:** Execute commands on App Server 2 and verify results
