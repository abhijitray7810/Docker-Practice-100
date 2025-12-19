# Node.js Web App - Docker Deployment

This repository contains a Dockerized Node.js web application deployed on App Server 3.

## Project Structure

```
/node_app/
├── Dockerfile
├── package.json
├── server.js
└── README.md
```

## Prerequisites

- Docker installed on App Server 3
- Access to App Server 3
- Node.js application files (package.json and server.js)

## Dockerfile Details

The Dockerfile uses the following configuration:

- **Base Image**: `node:16-alpine` (lightweight Node.js image)
- **Working Directory**: `/usr/src/app`
- **Dependencies**: Installed via npm using package.json
- **Exposed Port**: 8082
- **Entry Point**: `node server.js`

## Deployment Instructions

### 1. Navigate to the Application Directory

```bash
cd /node_app
```

### 2. Build the Docker Image

Build the Docker image with the tag `nautilus/node-web-app`:

```bash
docker build -t nautilus/node-web-app .
```

### 3. Run the Container

Run the container named `nodeapp_nautilus` with port mapping:

```bash
docker run -d --name nodeapp_nautilus -p 8091:8082 nautilus/node-web-app
```

**Port Mapping:**
- Container Port: 8082
- Host Port: 8091

### 4. Test the Application

Test the deployed application using curl:

```bash
curl http://localhost:8091
```

## Verification Commands

### Check Docker Image

```bash
docker images | grep nautilus/node-web-app
```

### Check Running Container

```bash
docker ps | grep nodeapp_nautilus
```

### View Container Logs

```bash
docker logs nodeapp_nautilus
```

### Follow Container Logs (Real-time)

```bash
docker logs -f nodeapp_nautilus
```

## Container Management

### Stop the Container

```bash
docker stop nodeapp_nautilus
```

### Start the Container

```bash
docker start nodeapp_nautilus
```

### Restart the Container

```bash
docker restart nodeapp_nautilus
```

### Remove the Container

```bash
docker stop nodeapp_nautilus
docker rm nodeapp_nautilus
```

### Remove the Image

```bash
docker rmi nautilus/node-web-app
```

## Troubleshooting

### Container Won't Start

Check the logs for errors:

```bash
docker logs nodeapp_nautilus
```

### Port Already in Use

If port 8091 is already in use, check what's using it:

```bash
sudo lsof -i :8091
```

Or use a different host port:

```bash
docker run -d --name nodeapp_nautilus -p 8092:8082 nautilus/node-web-app
```

### Application Not Responding

1. Check if the container is running:
   ```bash
   docker ps
   ```

2. Inspect the container:
   ```bash
   docker inspect nodeapp_nautilus
   ```

3. Execute commands inside the container:
   ```bash
   docker exec -it nodeapp_nautilus sh
   ```

## Rebuilding After Changes

If you make changes to the application code:

```bash
# Stop and remove the old container
docker stop nodeapp_nautilus
docker rm nodeapp_nautilus

# Rebuild the image
docker build -t nautilus/node-web-app .

# Run a new container
docker run -d --name nodeapp_nautilus -p 8091:8082 nautilus/node-web-app
```

## Additional Information

- **Image Name**: `nautilus/node-web-app`
- **Container Name**: `nodeapp_nautilus`
- **Internal Port**: 8082
- **External Port**: 8091
- **Server**: App Server 3

## Notes

- The Dockerfile is case-sensitive and must be named exactly `Dockerfile`
- The application runs in detached mode (-d flag)
- Port 8082 inside the container is mapped to port 8091 on the host
- The Alpine-based image is used for a smaller footprint
