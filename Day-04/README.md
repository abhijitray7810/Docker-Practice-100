# 🗑️ Container Deletion Guide
## Nautilus Project - App Server 3 Cleanup

---

## 📋 Task Summary
| **Component** | **Details** |
|---------------|-------------|
| **Container** | `kke-container` |
| **Server** | App Server 3 (stapp03) |
| **Environment** | Stratos DC |
| **Purpose** | Testing cleanup |
| **Platform** | Docker |

---

## 🚀 Quick Start
```bash
# Connect to server
ssh banner@stapp03

# Delete container (one-liner)
docker rm -f kke-container

# Verify deletion
docker ps -a | grep kke-container
```

---

## 📖 Detailed Steps

### 1️⃣ Access Server
```bash
# SSH into App Server 3
ssh banner@stapp03

# Switch to root if needed
sudo su -
```

### 2️⃣ Locate Container
```bash
# List all containers
docker ps -a

# Find specific container
docker ps -a | grep kke-container
```

### 3️⃣ Remove Container
```bash
# If stopped
docker rm kke-container

# If running
docker rm -f kke-container
```

### 4️⃣ Confirm Deletion
```bash
# Should return empty
docker ps -a | grep kke-container
```

---

## 🔧 Command Reference

| **Action** | **Command** |
|------------|-------------|
| **List containers** | `docker ps -a` |
| **Stop container** | `docker stop kke-container` |
| **Remove container** | `docker rm kke-container` |
| **Force remove** | `docker rm -f kke-container` |
| **Remove with volumes** | `docker rm -v kke-container` |

---

## ⚠️ Troubleshooting

### Container Running?
```bash
docker stop kke-container && docker rm kke-container
```

### Permission Issues?
```bash
sudo docker rm -f kke-container
```

### Container Not Found?
```bash
# List all containers to verify
docker ps -a
```

---

## ✅ Verification Checklist
- [ ] Connected to stapp03
- [ ] Located kke-container
- [ ] Container stopped (if running)
- [ ] Container deleted
- [ ] Deletion verified

---

## 📞 Support
- **Server**: stapp03 (172.16.238.12)
- **User**: banner
- **Platform**: Docker
- **Task**: Testing container cleanup

---
*Generated for Nautilus Project - Stratos DC*
```
