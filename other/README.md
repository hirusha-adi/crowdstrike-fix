# Fix manually

## If BitLocker is not enabled

Based on this [Reddit post](https://www.reddit.com/r/crowdstrike/comments/1e6vmkf/comment/ldvxx62/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button).

1. Boot Windows into safe mode
2. Go to `C:\Windows\System32\drivers\CrowdStrike`
3. Delete files matching the `C-00000291*.sys` pattern
4. Reboot

## If BitLocker is enabled

Based on this [Twitter post](https://x.com/Syndikalist/status/1814281141265846772/photo/1).

1. Cycle through BSODs until you get the recovery screen.
2. Navigate to Troubleshoot > Advanced Options > Startup Settings
3. Press "Restart"
4. Skip the first Bitlocker recovery key prompt by pressing Esc
5. Skip the second Bitlocker recovery key prompt by selecting Skip This Device in the bottom right
6. Navigate to Troubleshoot > Advanced Options > Command Prompt
7. Type `bcdedit /set {default} safeboot minimal`, then press enter
8. Go back to the WinRE main menu and select Continue
9. It may cycle 2-3 times
10. If you booted into safe mode, log in per normal
11. Open Windows Explorer, navigate to `C:\Windows\System32\drivers\CrowdStrike`
12. Delete the offending file (STARTS with `C-00000291*`, .sys file extension)
13. Open command prompt as administrator
14. Type `bcdedit /deletevalue {default} safeboot`, then press enter
15. Restart as normal, confirm normal behaviour

# Fix with a Batch script

Summary:

- A batch script that you can run in safemode to fix the issue

Supports Bitlocker Encryption?: No

Demonstration: [Youtube Video](https://youtu.be/xmKCybmhjNA)

https://github.com/user-attachments/assets/e4301b83-46f7-4ce0-a508-51f3c3ce9919

## One Liner

- NOTE that an internet connection and powershell is required to do this
- Open CMD as an administrator and run the command below

```bat
powershell -Command "Invoke-WebRequest -Uri https://raw.githubusercontent.com/hirusha-adi/crowdstrike-fix/main/other/fix.bat -OutFile fix.bat; Start-Process fix.bat -Wait; Remove-Item fix.bat"
```

- It will download the script, execute it, and remove it

## Via the GUI

- [Click here](https://raw.githubusercontent.com/hirusha-adi/crowdstrike-fix/main/other/fix.bat) to download the file.
- Right click and Run as administrator.

![image](https://github.com/user-attachments/assets/19ce821a-3057-498f-9fd6-7a1647c2eab5)

- The script should work as intended.

![image](https://github.com/user-attachments/assets/9091a913-ab9c-4bb1-a083-aeac20fcf0db)

# Fix with a Powershell script

Summary:

- A powershell script that you can run in safemode to fix the issue

Supports Bitlocker Encryption?: No

Demonstration: scroll down...

#### One Liner (internet required)

- NOTE that an internet connection is required to do this
- Open powershell as an administrator and run the command below

```ps1
iwr -useb https://raw.githubusercontent.com/hirusha-adi/crowdstrike-fix/main/other/fix.ps1 | iex
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

# Fix by booting from a Linux distribution

Summary:

- (live) boot into a Linux distribution from the affected computer and execute a the fix script.

Supports Bitlocker Encryption?: No

## Usage Guide

```bash
# get the script
wget https://raw.githubusercontent.com/hirusha-adi/crowdstrike-fix/main/other/fix.sh

# make it executable
chmod +x fix.sh

# run the script
./fix.sh
```
