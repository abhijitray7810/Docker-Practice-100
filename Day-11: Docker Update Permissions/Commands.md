# commands.md

## Grant Docker access to user `rose` on App Server 2

1. SSH into App Server 2  
   ```bash
   ssh user@app-server-2
   ```

2. Add `rose` to the `docker` group  
   ```bash
   sudo usermod -aG docker rose
   ```

3. Confirm group membership  
   ```bash
   groups rose
   ```

4. Activate new group membership (if already logged in as `rose`)  
   ```bash
   newgrp docker
   ```

5. Verify Docker can be run without sudo  
   ```bash
   docker ps
   ```
```
