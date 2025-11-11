# Step 1: Switch to App Server 2
ssh tony@<APP_SERVER_2_IP>

# Step 2: Create required directory
sudo mkdir -p /opt/docker

# Step 3: Create docker-compose.yml file
sudo vi /opt/docker/docker-compose.yml

# Add the following content:
# ---------------------------------
version: '3.8'

services:
  webserver:
    image: httpd:latest
    container_name: httpd
    ports:
      - "8086:80"
    volumes:
      - /opt/security:/usr/local/apache2/htdocs
# ---------------------------------

# Step 4: Navigate to directory
cd /opt/docker

# Step 5: Run Docker Compose
sudo docker compose up -d

# Step 6: Verify container is running
sudo docker ps

# Step 7: Test application
curl http://localhost:8086
