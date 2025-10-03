# DevOps 365 Days - Day 57 Challenge

## Scenario
An issue has arisen with a static website running in a container named `nautilus` on App Server 1. To resolve the issue, you need to investigate the following details:

## Requirements
1. Check if the container's volume `/usr/local/apache2/htdocs` is correctly mapped with the host's volume `/var/www/html`
2. Verify that the website is accessible on host port 8080 on App Server 1
3. Confirm that the command `curl http://localhost:8080/` works on App Server 1

## Investigation Steps Required
- Connect to App Server 1 as user `tony`
- Check container status and identify any issues
- Verify volume mounting configuration
- Test website accessibility
- Document findings and resolution

## Expected Outcome
- Successfully identify why the website is not accessible
- Resolve the issue using appropriate Docker commands
- Verify the fix works correctly
- Document the troubleshooting process

## Skills Tested
- Docker container management
- Volume mounting troubleshooting
- Network port verification
- Log analysis
- Systematic problem-solving approach
