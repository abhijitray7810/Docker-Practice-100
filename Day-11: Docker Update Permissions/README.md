

## Task Overview

- **Server:** App Server 3 (`stapp03`)
- **User:** `javed`
- **Requirement:** Allow user to run Docker commands without `sudo`.

---

## Step-by-Step Instructions

### 1. SSH into the target server
```bash
ssh banner@stapp03
````

> Accept the host key if prompted.

---

### 2. Add the user to the `docker` group

```bash
sudo usermod -aG docker javed
```

> `-aG` appends the user to the group without removing existing groups.

---

### 3. Verify group membership

```bash
id javed
```

Expected output:

```
uid=1002(javed) gid=1002(javed) groups=1002(javed),998(docker)
```

---

### 4. Test Docker commands

If you know the user's password, switch to the user:

```bash
su - javed
docker ps
```

If the password is unknown, run the command as the user using sudo:

```bash
sudo -u javed docker ps
```

> If the output shows running containers or an empty list, the setup is successful.

---

### 5. Optional: Reset user password (if needed)

```bash
sudo passwd javed
```

Set a new password to allow SSH or `su` login for the user.

---

## Notes

* Adding a user to the `docker` group allows running Docker commands **without sudo**.
* Changes take effect after the user logs in again or uses `su - <username>`.

---

```

I can also create a **ready-to-submit `commands.md` file** that includes all the actual shell commands you would run for Nautilus labs. Do you want me to do that next?
```
