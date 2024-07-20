$path = Join-Path -Path $env:WINDIR -ChildPath "System32\drivers\CrowdStrike"

# check if CrowdStrike folder exists
if (Test-Path -Path $path) {
    Write-Output "Found CrowdStrike folder in $path"
    Write-Output "====="
    
    # ls: before
    Get-ChildItem -Path $path

    # Find and delete all files matching C-00000291*.sys
    # ---
    $filesToDelete = Get-ChildItem -Path $path -Filter "C-00000291*.sys"
    
    foreach ($file in $filesToDelete) {
        try {
            Write-Output "Deleting: $($file.FullName)"
            Remove-Item -Path $file.FullName -Force
        }
        catch {
            Write-Output "Failed to delete file: $($file.FullName) - $($_.Exception.Message)"
        }
    }
    # ---

    # ls: after
    Get-ChildItem -Path $path
    Write-Output "====="

} else {
    Write-Output "CrowdStrike folder not found in $($env:WINDIR)\System32\drivers"
}

Write-Output "Script completed."
