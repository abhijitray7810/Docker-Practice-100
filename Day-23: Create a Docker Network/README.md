# Docker Network Setup - Media Network

## Overview
This document provides instructions for setting up a custom Docker network named `media` on App Server 3 in Stratos DC. This network will be used by the Nautilus DevOps team for various applications requiring isolated network environments.

## Prerequisites
- Access to App Server 3 in Stratos DC
- Docker installed and running
- Sufficient privileges to create Docker networks (root or sudo access)

## Network Specifications

| Parameter | Value |
|-----------|-------|
| Network Name | `media` |
| Driver | `bridge` |
| Subnet | `192.168.0.0/24` |
| IP Range | `192.168.0.0/24` |
| Available IPs | 254 usable addresses (192.168.0.1 - 192.168.0.254) |

## Installation Steps

### 1. Connect to App Server 3
```bash
ssh user@app-server-3
```

### 2. Create the Docker Network
Execute the following command to create the `media` network with the specified configuration:

```bash
docker network create media \
  --driver bridge \
  --subnet 192.168.0.0/24 \
  --ip-range 192.168.0.0/24
```

### 3. Verify Network Creation
Confirm the network was created successfully:

```bash
# List all Docker networks
docker network ls | grep media

# Inspect the media network
docker network inspect media
```

## Verification

The `docker network inspect media` command should return JSON output showing:

```json
{
    "Name": "media",
    "Driver": "bridge",
    "IPAM": {
        "Config": [
            {
                "Subnet": "192.168.0.0/24",
                "IPRange": "192.168.0.0/24"
            }
        ]
    }
}
```

## Usage Examples

### Connect a Container to the Media Network

**At container creation:**
```bash
docker run -d --name my-app --network media nginx:latest
```

**For existing containers:**
```bash
docker network connect media my-existing-container
```

### Assign a Specific IP Address
```bash
docker run -d --name my-app --network media --ip 192.168.0.10 nginx:latest
```

### Disconnect a Container
```bash
docker network disconnect media my-app
```

## Troubleshooting

### Issue: Network Already Exists
If you see an error that the network already exists:
```bash
# Remove the existing network (ensure no containers are connected)
docker network rm media

# Recreate with the correct configuration
docker network create media --driver bridge --subnet 192.168.0.0/24 --ip-range 192.168.0.0/24
```

### Issue: Subnet Conflict
If the subnet conflicts with existing networks:
```bash
# List all networks and their subnets
docker network ls
docker network inspect $(docker network ls -q)

# Remove conflicting networks if safe to do so
docker network rm <conflicting-network-name>
```

### Issue: Permission Denied
If you encounter permission errors:
```bash
# Run with sudo
sudo docker network create media --driver bridge --subnet 192.168.0.0/24 --ip-range 192.168.0.0/24

# Or add your user to the docker group
sudo usermod -aG docker $USER
# Log out and log back in for changes to take effect
```

## Network Management

### View Connected Containers
```bash
docker network inspect media --format='{{range .Containers}}{{.Name}} {{end}}'
```

### Remove the Network
**Warning:** Ensure no containers are connected before removing the network.

```bash
# Disconnect all containers first
docker network disconnect media <container-name>

# Remove the network
docker network rm media
```

## Additional Information

### Bridge Driver
The bridge driver creates a private internal network on the host. Containers connected to the same bridge network can communicate with each other, while remaining isolated from containers on other networks.

### Subnet and IP Range
- **Subnet (192.168.0.0/24)**: Defines the network address space
- **IP Range (192.168.0.0/24)**: Restricts which IPs Docker can assign to containers
- Both set to the same value means Docker can use any IP within the subnet

## Support
For issues or questions, contact the Nautilus DevOps team or refer to the official Docker documentation:
- [Docker Network Documentation](https://docs.docker.com/network/)
- [Docker Bridge Network](https://docs.docker.com/network/bridge/)

## Changelog

| Date | Version | Changes |
|------|---------|---------|
| 2025-11-04 | 1.0 | Initial network setup documentation |

---

**Document Owner:** Nautilus DevOps Team  
**Last Updated:** November 4, 2025  
**Server:** App Server 3, Stratos DC
