# Command Reference: Create Docker Image from Container

## Scenario  
Create a new image named `ecommerce:nautilus` from the running container `ubuntu_latest` on Application Server 1.

---

## 1. Confirm the source container is running
```bash
docker ps --filter name=ubuntu_latest
```

Expected output (example):
```
CONTAINER ID   IMAGE           COMMAND   CREATED        STATUS        PORTS   NAMES
a1b2c3d4e5f6   ubuntu:latest   "bash"    2 hours ago    Up 2 hours            ubuntu_latest
```

---

## 2. Commit the container to a new image
```bash
docker commit ubuntu_latest ecommerce:nautilus
```

Optional: add metadata  
```bash
docker commit \
  -a "DevOps Team" \
  -m "Backup of developer changes before upgrade" \
  ubuntu_latest \
  ecommerce:nautilus
```

---

## 3. Verify the new image exists
```bash
docker images ecommerce:nautilus
```

Expected output (example):
```
REPOSITORY     TAG        IMAGE ID       CREATED         SIZE
ecommerce      nautilus   4f8d8c9a0b1e   5 seconds ago   214 MB
```

---

## 4. (Optional) Save the image to a tar file for external backup
```bash
docker save ecommerce:nautilus | gzip > ecommerce_nautilus_backup_$(date +%F).tar.gz
```

---

## Quick one-liner (copy/paste)
```bash
docker commit ubuntu_latest ecommerce:nautilus && docker images ecommerce:nautilus
```
