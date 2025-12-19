# Python Application Docker Deployment

## Overview
This document provides instructions for Dockerizing and deploying a Python application on App Server 2 using Docker containers.

## Prerequisites
- Docker installed on App Server 2
- Python application source code with `server.py`
- `requirements.txt` file located at `/python_app/src/`
- Appropriate permissions to build and run Docker containers

## Project Structure
```
/python_app/
├── Dockerfile
└── src/
    ├── requirements.txt
    ├── server.py
    └── [other application files]
```

## Deployment Instructions

### Step 1: Create the Dockerfile

Create a `Dockerfile` in the `/python_app` directory:

```bash
cat > /python_app/Dockerfile << 'EOF'
# Use Python as base image
FROM python:3.9-slim

# Set working directory
WORKDIR /app

# Copy requirements file
COPY src/requirements.txt .

# Install dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy application code
COPY src/ .

# Expose port 3002
EXPOSE 3002

# Run the application
CMD ["python", "server.py"]
EOF
```

**Dockerfile Explanation:**
- `FROM python:3.9-slim`: Uses Python 3.9 slim image as the base
- `WORKDIR /app`: Sets the working directory inside the container
- `COPY src/requirements.txt .`: Copies the requirements file
- `RUN pip install`: Installs all Python dependencies
- `COPY src/ .`: Copies all application source code
- `EXPOSE 3002`: Exposes port 3002 for the application
- `CMD ["python", "server.py"]`: Runs the server script when container starts

### Step 2: Build the Docker Image

Navigate to the application directory and build the image:

```bash
cd /python_app
docker build -t nautilus/python-app .
```

**Build Options:**
- `-t nautilus/python-app`: Tags the image with the specified name
- `.`: Uses the current directory as the build context

### Step 3: Run the Container

Create and start a container from the built image:

```bash
docker run -d \
  --name pythonapp_nautilus \
  -p 8094:3002 \
  nautilus/python-app
```

**Run Options:**
- `-d`: Runs the container in detached mode (background)
- `--name pythonapp_nautilus`: Names the container
- `-p 8094:3002`: Maps host port 8094 to container port 3002
- `nautilus/python-app`: The image to use

### Step 4: Test the Application

Test the deployed application using curl:

```bash
curl http://localhost:8094/
```

## Quick Deployment Script

Run all steps at once using this script:

```bash
#!/bin/bash

# Create Dockerfile
cat > /python_app/Dockerfile << 'EOF'
FROM python:3.9-slim
WORKDIR /app
COPY src/requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
COPY src/ .
EXPOSE 3002
CMD ["python", "server.py"]
EOF

echo "✓ Dockerfile created"

# Build the image
cd /python_app
docker build -t nautilus/python-app .
echo "✓ Docker image built"

# Run the container
docker run -d \
  --name pythonapp_nautilus \
  -p 8094:3002 \
  nautilus/python-app
echo "✓ Container started"

# Wait for container to start
sleep 3

# Test the application
echo "Testing the application..."
curl http://localhost:8094/

# Show container status
echo -e "\n\nContainer status:"
docker ps | grep pythonapp_nautilus
```

## Verification Commands

### Check Docker Image
```bash
docker images | grep nautilus/python-app
```

### Check Running Container
```bash
docker ps | grep pythonapp_nautilus
```

### View Container Logs
```bash
docker logs pythonapp_nautilus
```

### View Real-time Logs
```bash
docker logs -f pythonapp_nautilus
```

### Inspect Container
```bash
docker inspect pythonapp_nautilus
```

## Container Management

### Stop the Container
```bash
docker stop pythonapp_nautilus
```

### Start the Container
```bash
docker start pythonapp_nautilus
```

### Restart the Container
```bash
docker restart pythonapp_nautilus
```

### Remove the Container
```bash
docker stop pythonapp_nautilus
docker rm pythonapp_nautilus
```

### Remove the Image
```bash
docker rmi nautilus/python-app
```

## Troubleshooting

### Container Won't Start
1. Check container logs:
   ```bash
   docker logs pythonapp_nautilus
   ```

2. Verify the image was built correctly:
   ```bash
   docker images nautilus/python-app
   ```

3. Check if port 8094 is already in use:
   ```bash
   netstat -tuln | grep 8094
   # or
   ss -tuln | grep 8094
   ```

### Application Not Responding
1. Verify container is running:
   ```bash
   docker ps | grep pythonapp_nautilus
   ```

2. Check container health:
   ```bash
   docker stats pythonapp_nautilus
   ```

3. Access container shell for debugging:
   ```bash
   docker exec -it pythonapp_nautilus /bin/bash
   ```

### Port Conflict
If port 8094 is already in use, either:
- Stop the service using that port
- Use a different host port:
  ```bash
  docker run -d --name pythonapp_nautilus -p 8095:3002 nautilus/python-app
  ```

### Rebuild After Code Changes
```bash
# Stop and remove old container
docker stop pythonapp_nautilus
docker rm pythonapp_nautilus

# Rebuild image
docker build -t nautilus/python-app /python_app

# Run new container
docker run -d --name pythonapp_nautilus -p 8094:3002 nautilus/python-app
```

## Network Configuration

- **Container Port**: 3002 (internal)
- **Host Port**: 8094 (external)
- **Access URL**: `http://localhost:8094/`

## Security Considerations

1. **Using slim images**: The `python:3.9-slim` image reduces attack surface
2. **No cache for pip**: `--no-cache-dir` reduces image size and potential vulnerabilities
3. **Non-root user** (optional enhancement):
   ```dockerfile
   RUN useradd -m appuser
   USER appuser
   ```

## Best Practices

1. **Version pinning**: Consider pinning exact Python version in Dockerfile
2. **Multi-stage builds**: For production, use multi-stage builds to reduce image size
3. **Health checks**: Add health check to Dockerfile:
   ```dockerfile
   HEALTHCHECK --interval=30s --timeout=3s \
     CMD curl -f http://localhost:3002/ || exit 1
   ```
4. **Environment variables**: Use `.env` files for configuration
5. **Volume mounting**: For development, mount source code as volume

## Additional Resources

- [Docker Documentation](https://docs.docker.com/)
- [Python Docker Best Practices](https://docs.docker.com/language/python/)
- [Dockerfile Reference](https://docs.docker.com/engine/reference/builder/)

## Support

For issues or questions:
1. Check container logs: `docker logs pythonapp_nautilus`
2. Review Dockerfile configuration
3. Verify requirements.txt dependencies
4. Check App Server 2 system resources

## License

[Add your license information here]

## Authors

[Add author information here]
