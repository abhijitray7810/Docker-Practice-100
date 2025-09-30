# Application Server 1 Connection Details
 Server Information:
  Hostname: stapp01.stratos.xfusioncorp.com
  IP Address: 172.16.238.10
  User: tony
  Password: Ir0nM@n
# Steps to Deploy nginx_1 Container on Application Server 1
  ## 1. Connect to Application Server 1
    
     ssh tony@stapp01.stratos.xfusioncorp.com 
     or
     ssh tony@172.16.238.10

 ## 2. Create the nginx_1 container   
     docker run -d --name nginx_1 nginx:alpine

 ## 3. Verify the container is running
     docker ps

 ## 4. Verify nginx is working (optional)
     
      docker logs nginx_1


      docker exec nginx_1 wget -qO- localhost
