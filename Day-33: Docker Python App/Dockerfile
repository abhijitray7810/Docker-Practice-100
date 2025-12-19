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
