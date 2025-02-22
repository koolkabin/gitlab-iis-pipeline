#gitlab-ci/cd

This is deployment template files for:
- self hosted gitlab runner in windows
- gitlab runner configured to use powershell
- IIS Web Applications [.net core web api/.net web mvc/static html]
- IIS Web Server

# Deployment Strategy

## Overview
This document outlines the deployment strategy for the web application using a self-hosted GitLab Runner and IIS.

## Deployment Workflow
1. **Build the Application**  
   - The developer compiles the application and generates the necessary build files.

2. **Copy Files to Deployment Folder**  
   - The compiled files are added to the `www` folder.

3. **Trigger GitLab Deployment Job**  
   - The developer runs `git_push.bat`, which pushes changes to the GitLab repository.

4. **GitLab Runner Execution**  
   - The self-hosted GitLab Runner detects the push and starts a deployment job.

5. **Stop IIS Services**  
   - The GitLab Runner stops the IIS website and the IIS application pool to prevent conflicts during deployment.

6. **Backup Important Files**  
   - Essential files like `appsettings.json` and the `private` folder are backed up to a `bkp` folder.

7. **Remove Old Files**  
   - All existing files in the deployment directory, except the `bkp` folder, are removed.

8. **Deploy New Files**  
   - The newly compiled files from the GitLab Runner source are copied to the destination deployment location.

9. **Restart IIS Services**  
   - The IIS website and the IIS application pool are restarted to make the new version live.

10. **Complete Deployment**  
    - The GitLab Runner completes the deployment process, and the IIS-hosted web application is updated successfully.

## Notes
- Ensure that the `bkp` folder is always available to prevent loss of critical configurations.
- Monitor the GitLab Runner logs for any deployment errors.
- Verify IIS services after deployment to confirm the application is running correctly.

## Troubleshooting
- If the deployment fails:
  - Check the GitLab Runner logs for error messages.
  - Ensure that IIS services have the correct permissions.
  - Confirm that the necessary files are correctly backed up and restored.
- If the website does not start:
  - Restart the IIS application pool manually.
  - Check the application logs for missing dependencies.

## Contact
For issues or improvements in the deployment strategy, contact the development team.

