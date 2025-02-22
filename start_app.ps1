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
    
    if ($appPoolState -ne 'Started') {
        Write-Output ('Starting Website Pool: {0}' -f $webSiteName)
        Start-Website -Name $webSiteName
    }
    
    if ($webSiteState -ne 'Started') {
        Write-Output ('Starting Application Pool: {0}' -f $appPoolName)
        Start-WebAppPool -Name $appPoolName
    }
    
    Start-Sleep -Seconds $waitTime
    
    # Check again after waiting
    $appPoolState = (Get-WebAppPoolState -Name $appPoolName).Value
    $webSiteState = (Get-WebsiteState -Name $webSiteName).Value
    
    if ($appPoolState -eq 'Started' -and $webSiteState -eq 'Started') {
        Write-Output 'Both Application Pool and Website are Started.'
        break
    }
    
    $attempt++
}

if ($attempt -eq $maxAttempts) {
    Write-Output 'Reached maximum attempts. The Application Pool or Website may not be fully Started.'
}
