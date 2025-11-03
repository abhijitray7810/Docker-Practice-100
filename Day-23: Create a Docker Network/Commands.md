# Docker Network Setup - Media Network

### Task Details
The Nautilus DevOps team needs to create a Docker network for future use.

**Requirements:**
- **Network Name:** media  
- **Driver:** bridge  
- **Subnet:** 192.168.0.0/24  
- **IP Range:** 192.168.0.0/24  
- **Server:** App Server 3 (Stratos DC)

---

### Step 1: SSH into App Server 3
```bash
ssh tony@stapp03
````

---

### Step 2: Create the Docker Network

```bash
docker network create --driver bridge --subnet 192.168.0.0/24 --ip-range 192.168.0.0/24 media
```

---

### Step 3: Verify Network Creation

```bash
docker network ls
```

---

### Step 4: Inspect the Network Configuration

```bash
docker network inspect media
```

Expected output should include:

```json
"IPAM": {
    "Config": [
        {
            "Subnet": "192.168.0.0/24",
            "IPRange": "192.168.0.0/24"
        }
    ]
}
```

---

### ✅ Task Verification

If the inspection shows the correct subnet, IP range, and bridge driver, the setup is complete.

```
