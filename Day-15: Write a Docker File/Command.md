# command.me - Create Dockerfile for Nautilus Application Development Team
# Task: Create a Dockerfile on App Server 3 in Stratos DC with ubuntu:24.04 base and apache2 on port 3000

# Step 1: Connect to App Server 3
```
ssh banner@stapp03.stratos.xfusioncorp.com
```

# OR
```

ssh banner@172.16.238.12
```

# Step 2: Switch to root user (required for creating directories in /opt)
```

sudo su -
```

# Step 3: Create the required directory
```

mkdir -p /opt/docker
```

# Step 4: Navigate to the docker directory
```

cd /opt/docker
```

# Step 5: Create the Dockerfile (note the capital D)
```

vi Dockerfile
```

# Step 6: Add the following content to the Dockerfile
# Press 'i' to enter insert mode, then paste this content:
```

FROM ubuntu:24.04
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && \
    apt-get install -y apache2 && \
    apt-get clean
RUN sed -i 's/Listen 80/Listen 3000/' /etc/apache2/ports.conf && \
    sed -i 's/<VirtualHost \*:80>/<VirtualHost *:3000>/' /etc/apache2/sites-available/000-default.conf
EXPOSE 3000
CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]
```

# Step 7: Save and exit vi
# Press 'Esc' to exit insert mode, then type ':wq' and press Enter

# Step 8: Verify the Dockerfile was created correctly
```
cat /opt/docker/Dockerfile
```

# Step 9: (Optional) Build the Docker image to test
```

sudo docker build -t nautilus-apache-3000 .
```

# Step 10: (Optional) Run the container to test
```

sudo docker run -d -p 3000:3000 --name nautilus-test nautilus-apache-3000
```

# Step 11: (Optional) Verify the container is running
```

sudo docker ps
```

# Step 12: (Optional) Test Apache is working on port 3000
```

curl http://localhost:3000
```

# End of commands
