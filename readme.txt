# Streamlining Web Application Deployment with GitLab Runner and IIS

[Read the full blog post](https://blog.outsourcingnepal.com/2025/02/streamlining-web-application-deployment-with-gitlab-runner-and-iis/)

## Overview
This repository provides deployment template files for automating the deployment of web applications using a self-hosted GitLab Runner and IIS.

## Supported Environments
- **Self-hosted GitLab Runner** (Windows)
- **GitLab Runner** configured to use PowerShell
- **IIS Web Applications** (ASP.NET Core Web API / ASP.NET MVC / Static HTML)
- **IIS Web Server**

## Deployment Strategy

### Workflow
1. **Build the Application**  
   - Compile the application and generate necessary build files.

2. **Copy Files to Deployment Folder**  
   - Move the compiled files to the `www` folder.

3. **Trigger GitLab Deployment Job**  
   - Execute `git_push.bat` to push changes to the GitLab repository.

4. **GitLab Runner Execution**  
   - The self-hosted GitLab Runner detects the push and initiates the deployment job.

5. **Stop IIS Services**  
   - Temporarily stop the IIS website and application pool to prevent conflicts.

6. **Backup Important Files**  
   - Backup essential files such as `appsettings.json` and the `private` folder to a `bkp` directory.

7. **Remove Old Files**  
   - Delete existing files in the deployment directory except for the `bkp` folder.

8. **Deploy New Files**  
   - Copy the new compiled files from the GitLab Runner source to the deployment location.

9. **Restart IIS Services**  
   - Restart the IIS website and application pool to apply changes.

10. **Complete Deployment**  
    - The deployment process completes, and the updated application is now live.

## Notes
- The `bkp` folder must always be available to avoid loss of critical configurations.
- Monitor GitLab Runner logs for any errors.
- Verify IIS services post-deployment to ensure the application is running correctly.

## Troubleshooting
If the deployment fails:
- Check GitLab Runner logs for error messages.
- Ensure IIS services have the correct permissions.
- Confirm necessary files are correctly backed up and restored.

If the website does not start:
- Restart the IIS application pool manually.
- Check application logs for missing dependencies.

## Contact
For any issues or improvements, feel free to reach out to the development team.
