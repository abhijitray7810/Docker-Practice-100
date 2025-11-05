# Task: Deploy nginx container on Application Server 3

## Steps and Commands

### a. Pull nginx:alpine docker image
```bash
docker pull nginx:alpine
````

### b. Create a container named `apps` using the pulled image

```bash
docker run -d --name apps -p 5002:80 nginx:alpine
```

### c. Verify the container is running

```bash
docker ps
```

### d. (Optional) Test the nginx service

```bash
curl http://localhost:5002
```

## Expected Output

You should see the default **Nginx welcome page HTML** if everything is configured correctly.

```

---

Would you like me to add a short **summary section** (like purpose, server, image, and port mapping) at the top of this file?
```
