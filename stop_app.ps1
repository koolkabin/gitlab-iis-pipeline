param ($webSiteName, $appPoolName)
import-module WebAdministration

if (-not $appPoolName) {
    $appPoolName = $webSiteName
}

$maxAttempts = 10
$attempt = 0
$waitTime = 5  # Seconds

while ($attempt -lt $maxAttempts) {
    $appPoolState = (Get-WebAppPoolState -Name $appPoolName).Value
    $webSiteState = (Get-WebsiteState -Name $webSiteName).Value
    
    if ($appPoolState -ne 'Stopped') {
        Write-Output ('Stopping Application Pool: {0}' -f $appPoolName)
        Stop-WebAppPool -Name $appPoolName
    }
    
    if ($webSiteState -ne 'Stopped') {
        Write-Output ('Stopping Website: {0}' -f $webSiteName)
        Stop-Website -Name $webSiteName
    }
    
    Start-Sleep -Seconds $waitTime
    
    # Check again after waiting
    $appPoolState = (Get-WebAppPoolState -Name $appPoolName).Value
    $webSiteState = (Get-WebsiteState -Name $webSiteName).Value
    
    if ($appPoolState -eq 'Stopped' -and $webSiteState -eq 'Stopped') {
        Write-Output 'Both Application Pool and Website are stopped.'
        break
    }
    
    $attempt++
}

if ($attempt -eq $maxAttempts) {
    Write-Output 'Reached maximum attempts. The Application Pool or Website may not be fully stopped.'
}
