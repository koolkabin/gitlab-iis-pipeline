param ($dest, $src)

$waitTime = 2  # Seconds

if (-not $src) {
    $src = $env:CI_PROJECT_DIR
}

New-Item -ItemType Directory -Path "$dest\bkp"

# Move important files to backup
if (Test-Path "$dest\www\appsettings.json") { 
    Move-Item -Path "$dest\www\appsettings.json" -Destination "$dest\bkp\appsettings.json" -Force 
}
if (Test-Path "$dest\www\private") { 
    Move-Item -Path "$dest\www\private" -Destination "$dest\bkp\private" -Force 
}

#wait a min...
Start-Sleep -Seconds $waitTime

# Remove all folders in $dest except bkp
Get-ChildItem -Path "$dest" -Force | Where-Object { $_.Name -ne "bkp" } | Remove-Item -Recurse -Force

#wait a min...
Start-Sleep -Seconds $waitTime

# Copy new files from src to dest
xcopy "$src" "$dest" /E /I /Y

# Restore backed-up files
if (Test-Path "$src\web.config") { 
    Copy-Item -Path "$src\web.config" -Destination "$dest\www\web.config" -Force 
}

if (Test-Path "$dest\bkp\appsettings.json") { 
    Move-Item -Path "$dest\bkp\appsettings.json" -Destination "$dest\www\appsettings.json" -Force 
}
if (Test-Path "$dest\bkp\private") { 
    Move-Item -Path "$dest\bkp\private" -Destination "$dest\www\private" -Force 
}