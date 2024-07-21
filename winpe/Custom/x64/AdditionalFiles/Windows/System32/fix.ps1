Write-Output "====="
Write-Output "Starting script."
Write-Output "====="

# Function to check and delete files in the specified path
function CheckAndDeleteFiles($path) {
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
        Write-Output "CrowdStrike folder not found in $path"
    }
}

# Get all drives
$drives = Get-PSDrive -PSProvider FileSystem

foreach ($drive in $drives) {
    $path = Join-Path -Path $drive.Root -ChildPath "Windows\System32\drivers\CrowdStrike"
    CheckAndDeleteFiles -path $path
}

Write-Output "====="
Write-Output "Script completed."
Write-Output "====="
