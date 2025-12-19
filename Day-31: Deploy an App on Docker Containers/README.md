# Nautilus Application - Dockerized Deployment Guide

## Overview

This repository contains the Docker Compose configuration for deploying the Nautilus Application on App Server 2 in the Stratos Datacenter. The stack consists of a PHP web application with Apache and a MariaDB database backend.

## Architecture

The application stack consists of two main services:

- **Web Service (php_blog)**: PHP application with Apache web server
- **Database Service (mysql_blog)**: MariaDB database server

Both services are connected via a custom Docker bridge network for secure inter-service communication.

## Prerequisites

- Docker Engine (version 20.10 or higher)
- Docker Compose (version 1.29 or higher)
- Root or sudo access on App Server 2
- Ports 3001 and 3306 available on the host

## Directory Structure

```
/opt/security/
├── docker-compose.yml    # Main compose configuration file
└── README.md            # This file

/var/www/html/           # Web application files (mounted volume)
/var/lib/mysql/          # Database data files (mounted volume)
```

## Installation Steps

### 1. Prepare the Environment

Create necessary directories:

```bash
sudo mkdir -p /opt/security
sudo mkdir -p /var/www/html
sudo mkdir -p /var/lib/mysql
```

### 2. Deploy the Configuration

Navigate to the deployment directory and copy the docker-compose.yml file:

```bash
cd /opt/security
# Place the docker-compose.yml file here
```

### 3. Start the Application Stack

Deploy all services:

```bash
sudo docker-compose up -d
```

The `-d` flag runs containers in detached mode (background).

### 4. Verify Deployment

Check container status:

```bash
sudo docker-compose ps
```

Expected output:
```
Name                Command              State           Ports
--------------------------------------------------------------------------------
mysql_blog    docker-entrypoint.sh mysqld   Up      0.0.0.0:3306->3306/tcp
php_blog      docker-php-entrypoint apac... Up      0.0.0.0:3001->80/tcp
```

### 5. Test the Application

Test web service accessibility:

```bash
curl localhost:3001/
# or
curl http://<server-ip>:3001/
```

## Service Details

### Web Service (php_blog)

| Property | Value |
|----------|-------|
| Container Name | php_blog |
| Image | php:apache |
| Host Port | 3001 |
| Container Port | 80 |
| Volume Mount | /var/www/html:/var/www/html |
| Network | app_network |

### Database Service (mysql_blog)

| Property | Value |
|----------|-------|
| Container Name | mysql_blog |
| Image | mariadb:latest |
| Host Port | 3306 |
| Container Port | 3306 |
| Volume Mount | /var/lib/mysql:/var/lib/mysql |
| Network | app_network |

#### Database Credentials

- **Database Name**: database_blog
- **Username**: blog_user
- **Password**: BlogP@ssw0rd#2024!
- **Root Password**: R00tP@ssw0rd#2024!

⚠️ **Security Note**: Change these credentials in production environments!

## Common Operations

### View Container Logs

View logs for all services:
```bash
sudo docker-compose logs
```

View logs for specific service:
```bash
sudo docker-compose logs web
sudo docker-compose logs db
```

Follow logs in real-time:
```bash
sudo docker-compose logs -f
```

### Stop the Application

Stop all services without removing containers:
```bash
sudo docker-compose stop
```

### Start Stopped Services

```bash
sudo docker-compose start
```

### Restart Services

```bash
sudo docker-compose restart
```

### Stop and Remove Containers

```bash
sudo docker-compose down
```

To also remove volumes:
```bash
sudo docker-compose down -v
```

### Access Container Shell

Access PHP container:
```bash
sudo docker exec -it php_blog bash
```

Access MariaDB container:
```bash
sudo docker exec -it mysql_blog bash
```

### Connect to Database

From host machine:
```bash
mysql -h localhost -P 3306 -u blog_user -p database_blog
# Enter password: BlogP@ssw0rd#2024!
```

From within the php_blog container:
```bash
mysql -h mysql_blog -u blog_user -p database_blog
```

## Troubleshooting

### Container Won't Start

Check logs:
```bash
sudo docker-compose logs [service-name]
```

Verify port availability:
```bash
sudo netstat -tulpn | grep -E '3001|3306'
```

### Database Connection Issues

Verify database is running:
```bash
sudo docker-compose ps db
```

Test database connectivity:
```bash
sudo docker exec -it mysql_blog mysql -u blog_user -p -e "SHOW DATABASES;"
```

### Permission Issues

Ensure proper ownership of volume directories:
```bash
sudo chown -R www-data:www-data /var/www/html
sudo chown -R 999:999 /var/lib/mysql  # MariaDB UID
```

### Web Service Returns 404

Ensure application files exist in /var/www/html:
```bash
ls -la /var/www/html
```

Create a test file:
```bash
echo "<?php phpinfo(); ?>" | sudo tee /var/www/html/index.php
```

### Clear and Rebuild

If you need to start fresh:
```bash
sudo docker-compose down -v
sudo rm -rf /var/lib/mysql/*
sudo docker-compose up -d
```

## Maintenance

### Backup Database

```bash
sudo docker exec mysql_blog mysqldump -u blog_user -pBlogP@ssw0rd#2024! database_blog > backup_$(date +%Y%m%d).sql
```

### Restore Database

```bash
sudo docker exec -i mysql_blog mysql -u blog_user -pBlogP@ssw0rd#2024! database_blog < backup_20241219.sql
```

### Update Images

Pull latest images:
```bash
sudo docker-compose pull
```

Recreate containers with new images:
```bash
sudo docker-compose up -d --force-recreate
```

## Network Configuration

The services communicate over a custom bridge network named `app_network`. This provides:

- Service discovery by container name
- Isolation from other Docker networks
- Controlled inter-service communication

## Security Considerations

1. **Change Default Passwords**: Update database credentials before production use
2. **Firewall Rules**: Restrict access to ports 3001 and 3306
3. **Volume Permissions**: Ensure proper file permissions on mounted volumes
4. **Regular Updates**: Keep Docker images updated for security patches
5. **SSL/TLS**: Consider adding SSL certificates for production environments

## Support

For issues or questions regarding this deployment:

- Check Docker Compose logs: `sudo docker-compose logs`
- Review Docker documentation: https://docs.docker.com/compose/
- Contact the Nautilus DevOps team

## Version History

- **v1.0.0** - Initial deployment configuration
  - PHP Apache web service
  - MariaDB database service
  - Docker Compose v3.8 configuration

## License

Internal use only - Stratos Datacenter / Nautilus Application Team
