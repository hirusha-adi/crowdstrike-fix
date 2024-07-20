$path = Join-Path -Path $env:WINDIR -ChildPath "System32\drivers\CrowdStrike"

# check if CrowdStrike folder exists
if (Test-Path -Path $path) {
    Write-Output "Found CrowdStrike folder in $path"
    
    # ls
    Get-ChildItem -Path $path
} else {
    Write-Output "CrowdStrike folder not found in $($env:WINDIR)\System32\drivers"
}

Write-Output "Script completed."
