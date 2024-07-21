# Fix with a Powershell script

Summary:

- A powershell script that you can run in safemode to fix the issue

Supports Bitlocker Encryption?: No

Demonstration: scroll down...

#### One Liner (internet required)

- NOTE that an internet connection is required to do this
- Open powershell as an administrator and run the command below

```ps1
iwr -useb https://raw.githubusercontent.com/hirusha-adi/crowdstrike-fix/main/fix.ps1 | iex
```

- It will download the script, execute it, and remove it
- Demonstration: [Youtube](https://youtu.be/NfoXMKk4aZg)

https://github.com/user-attachments/assets/692f218c-d8b7-4af6-9d53-b682eb7fcc90

#### One Liner (works offline)

- NO internet connection is required for this one-liner to work
- Open powershell as an administrator and run the command below

```ps1
Write-Output "====="; Write-Output "Starting script."; Write-Output "====="; $path = Join-Path -Path $env:WINDIR -ChildPath "System32\drivers\CrowdStrike"; if (Test-Path -Path $path) { Write-Output "Found CrowdStrike folder in $path"; Write-Output "====="; Get-ChildItem -Path $path; $filesToDelete = Get-ChildItem -Path $path -Filter "C-00000291*.sys"; foreach ($file in $filesToDelete) { try { Write-Output "Deleting: $($file.FullName)"; Remove-Item -Path $file.FullName -Force } catch { Write-Output "Failed to delete file: $($file.FullName) - $($_.Exception.Message)" } }; Get-ChildItem -Path $path; Write-Output "====="; } else { Write-Output "CrowdStrike folder not found in $($env:WINDIR)\System32\drivers" }; Write-Output "====="; Write-Output "Script completed."; Write-Output "=====";
```

- Demonstration: [Youtube](https://youtu.be/7SXNT6lTb_4)

https://github.com/user-attachments/assets/fa7d4b69-e741-40d5-8d5a-d8793cb755fa
