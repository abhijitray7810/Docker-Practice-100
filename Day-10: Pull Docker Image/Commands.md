## 1. Connect to App Server 2
```bash
ssh steve@172.16.238.11   # or ssh steve@stapp02
# supply sudo-user password when prompted
```

## 2. Pull the required image
```bash
docker pull busybox:musl
```

## 3. Create the new tag
```bash
docker tag busybox:musl busybox:media
```

## 4. Confirm both tags point to the same image
```bash
docker images | grep busybox
```
Expected output:
```
REPOSITORY   TAG       IMAGE ID       CREATED        SIZE
busybox      musl      44f1048931f5   12 months ago  1.46MB
busybox      media     44f1048931f5   12 months ago  1.46MB
```

Done – the Nautilus project can now reference `busybox:media` in their containerized tests.
```
