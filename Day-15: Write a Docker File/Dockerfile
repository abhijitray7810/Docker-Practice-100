# Use Ubuntu 24.04 as base image
FROM ubuntu:24.04

# Set environment variables to avoid interactive prompts during installation
ENV DEBIAN_FRONTEND=noninteractive

# Update package list and install Apache2
RUN apt-get update && \
    apt-get install -y apache2 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Configure Apache to listen on port 3000
RUN sed -i 's/Listen 80/Listen 3000/g' /etc/apache2/ports.conf && \
    sed -i 's/:80/:3000/g' /etc/apache2/sites-available/000-default.conf

# Expose port 3000
EXPOSE 3000

# Start Apache in foreground
CMD ["apachectl", "-D", "FOREGROUND"]
