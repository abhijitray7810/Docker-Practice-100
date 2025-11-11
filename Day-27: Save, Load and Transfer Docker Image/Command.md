# Transfer Docker Image Between Servers

## Step 1: On App Server 1
```bash
# Start Docker service if not running
sudo systemctl start docker
```
# Save the Docker image as an archive
```bash
sudo docker save -o /tmp/news_nautilus.tar news:nautilus
```
# Transfer the image archive to App Server 3
```bash
scp /tmp/news_nautilus.tar banner@stapp03:/tmp/
Step 2: On App Server 3
```
```bash
# Start Docker service if not running
sudo systemctl start docker
```
# Load the Docker image from the transferred archive
```bash
sudo docker load -i /tmp/news_nautilus.tar
```
# Verify the image is loaded correctly
```bash
sudo docker images
```
