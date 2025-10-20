# Docker Image Creation from Container

## Overview
This guide provides instructions for creating a Docker image from a running container on Application Server 1. This process allows developers to backup and preserve changes made to containers during development and testing.

## Task Details

**Objective**: Create a new Docker image from an existing running container to preserve developer changes.

**Specifications**:
- **Server**: Application Server 1
- **Source Container**: `ubuntu_latest`
- **Target Image**: `ecommerce:nautilus`

## Prerequisites

- Docker must be installed and running on Application Server 1
- The container `ubuntu_latest` must be running
- Appropriate permissions to execute Docker commands (root or docker group membership)

## Implementation Steps

### Step 1: Verify Container Status

First, confirm that the source container is running:

```bash
docker ps | grep ubuntu_latest
```

Expected output should show the container in running state.

### Step 2: Create Image from Container

Execute the docker commit command to create the image:

```bash
docker commit ubuntu_latest ecommerce:nautilus
```

This command captures the current state of the container including all modifications made by the developer.

### Step 3: Verify Image Creation

Confirm the image was created successfully:

```bash
docker images ecommerce
```

Expected output:
```
REPOSITORY   TAG        IMAGE ID       CREATED          SIZE
ecommerce    nautilus   <image_id>     <seconds> ago    <size>
```

## Alternative: Create Image with Metadata

For better documentation and tracking, you can add commit message and author information:

```bash
docker commit -m "Backup of developer changes" -a "DevOps Team" ubuntu_latest ecommerce:nautilus
```

### Parameters Explained:
- `-m`: Commit message describing the changes
- `-a`: Author name for the commit

## Verification Commands

### List All Images
```bash
docker images
```

### Inspect Image Details
```bash
docker inspect ecommerce:nautilus
```

### View Image History
```bash
docker history ecommerce:nautilus
```

## Troubleshooting

### Container Not Found
If you receive an error about the container not existing:
```bash
# List all containers (including stopped ones)
docker ps -a

# Start the container if it's stopped
docker start ubuntu_latest
```

### Permission Denied
If you encounter permission issues:
```bash
# Add user to docker group
sudo usermod -aG docker $USER

# Or run with sudo
sudo docker commit ubuntu_latest ecommerce:nautilus
```

### Image Already Exists
If an image with the same name exists:
```bash
# Remove existing image
docker rmi ecommerce:nautilus

# Or tag with a different version
docker commit ubuntu_latest ecommerce:nautilus-v2
```

## Best Practices

1. **Always verify the container is running** before creating an image
2. **Use meaningful tags** to identify different versions (e.g., nautilus-v1, nautilus-dev)
3. **Add commit messages** using `-m` flag for better documentation
4. **Test the image** by running a new container from it before deployment
5. **Push to registry** for backup and sharing across team

## Testing the New Image

After creation, verify the image works correctly:

```bash
# Run a container from the new image
docker run -it --name test_ecommerce ecommerce:nautilus /bin/bash

# Verify changes are preserved
# Exit the container
exit

# Clean up test container
docker rm test_ecommerce
```

## Additional Resources

- [Docker Commit Documentation](https://docs.docker.com/engine/reference/commandline/commit/)
- [Docker Images Documentation](https://docs.docker.com/engine/reference/commandline/images/)
- [Docker Best Practices](https://docs.docker.com/develop/dev-best-practices/)

## Notes

- The commit process creates a new layer containing all changes made to the container
- The resulting image includes all files, installed packages, and configurations from the container
- Container must be running or in stopped state (not removed) for commit to work
- Image size will reflect the current state including all changes and additions

## Support

For issues or questions related to this task, contact the DevOps team or refer to the internal Docker documentation. 
