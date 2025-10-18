# Command.md – Apache2 on kkloud container (App Server 2)

## 1. SSH to App Server 2
```bash
ssh user@<APP_SERVER_2_IP>
```

## 2. Enter the running container
```bash
docker exec -it kkloud bash
```

## 3. One-liner inside container (run as root)
```bash
# update, install, re-configure port, restart, verify
apt-get update && \
apt-get install -y apache2 && \
sed -i 's/Listen 80/Listen 8087/' /etc/apache2/ports.conf && \
sed -i 's/:80/:8087/' /etc/apache2/sites-enabled/000-default.conf && \
service apache2 restart && \
service apache2 status && \
netstat -tlnp | grep 8087
```

## 4. Quick test (still inside container)
```bash
curl -I localhost:8087
curl -I 127.0.0.1:8087
```

## 5. Exit container (keep it running)
```bash
exit
```

## 6. Optional – test from host
```bash
docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' kkloud
# use returned IP
curl <container_ip>:8087
```

Apache2 is now listening on port 8087 on every interface; container stays up.
```
