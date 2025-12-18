# Use a valid base image
FROM httpd:latest

# Set working directory
WORKDIR /usr/local/apache2/htdocs

# Copy files with proper permissions
COPY index.html .
RUN chmod 644 index.html

# Expose the correct port
EXPOSE 80

# Use proper CMD syntax
CMD ["httpd-foreground"]
