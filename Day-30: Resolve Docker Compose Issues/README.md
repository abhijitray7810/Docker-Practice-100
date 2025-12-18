# Docker Compose Application

This project sets up a multi-container Docker application using Docker Compose.

## Project Structure
```
/opt/docker/
├── docker-compose.yml    # Main docker compose configuration
└── app/                  # Web application directory
    ├── Dockerfile        # Dockerfile for web service
    └── [application files] # Application source code
```

## Services

### 1. Web Service (python)
- **Container Name**: `python`
- **Build Context**: `./app` (builds from Dockerfile in app directory)
- **Port Mapping**: `5000:5000` (host:container)
- **Volume Mount**: `./app:/code` (mounts app directory to /code in container)
- **Dependencies**: Depends on redis service

### 2. Redis Service (redis)
- **Container Name**: `redis`
- **Image**: `redis:alpine`
- **Ports**: Exposes Redis default port 6379 internally

## Prerequisites
- Docker installed
- Docker Compose installed
- Appropriate permissions to run Docker commands

## Usage

### Starting the Application
```bash
cd /opt/docker
docker-compose up -d
```

### Stopping the Application
```bash
cd /opt/docker
docker-compose down
```

### Viewing Logs
```bash
cd /opt/docker
docker-compose logs
```

### Viewing Container Status
```bash
cd /opt/docker
docker-compose ps
```

### Rebuilding Services
```bash
cd /opt/docker
docker-compose build
docker-compose up -d
```

## Port Information
- **Web Application**: Accessible at `http://<host_ip>:5000`
- **Redis**: Available internally on port 6379 (not exposed to host)

## Important Notes
1. The application code is mounted as a volume, so changes in the `app` directory will be reflected in the container without rebuilding
2. The web service (`python`) waits for the redis service to be ready before starting
3. Container names are fixed as `python` and `redis` as per requirements

## Troubleshooting
If the application fails to start:
1. Check Docker daemon status: `sudo systemctl status docker`
2. Validate docker-compose file: `docker-compose config`
3. Check for port conflicts on port 5000
4. Review application logs: `docker-compose logs web`

## Maintenance
- To update the application, modify files in the `app` directory
- To update Redis version, modify the image tag in docker-compose.yml
- Regular Docker maintenance: `docker system prune` (removes unused containers, networks, images)

## Security Considerations
1. Only port 5000 is exposed to the host network
2. Redis is not exposed externally (only accessible within Docker network)
3. Consider adding environment variables for sensitive configuration
4. Regularly update base images for security patches
