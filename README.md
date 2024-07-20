# Crowdstrike Fix

To fix the issue that arose in 7/19/2024. The fix is based on this [reddit post](https://www.reddit.com/r/crowdstrike/comments/1e6vmkf/comment/ldvxx62/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button).

## Limitations

This will not work if the volume in which the Windows installation exists is encrypted with BitLocker. [Click here](#if-bitlocker-is-enabled) to learn more about the fix when BitLocker is enabled, you will have to do it manually.

## Usage Guide

### Using the bootable image (incomplete)

- [Click here](#using-the-bootable-image-incomplete) to download the bootable image (which is based on Arch Linux) of size: `1.1GB`.
- Flash the image to a pendrive to make it bootable.
- Plug-in the bootable pendrive to your device and boot from it.
- Wait for it to load and fix the disk.
- Once fixed, your device will be shutdown automatically.
- You can then eject the pendrive and boot to Windows.
- TODO: Add images and video guides.

### Using the script by booting into a Linux distro

- If you are already booted into a Linux distribution, you can run the fix script directly,

```bash
# get the script
wget https://raw.githubusercontent.com/hirusha-adi/crowdstrike-fix/main/fix.sh

# make it executable
chmod +x fix.sh

# run the script
./fix.sh
```

### Using the Batch file

- If you don't want to use the ISO, you can use the batch script

#### One Liner

- NOTE that an internet connection is required to do this
- Open CMD as an administrator and run the command below

```bat
powershell -Command "Invoke-WebRequest -Uri https://raw.githubusercontent.com/hirusha-adi/crowdstrike-fix/main/fix.bat -OutFile fix.bat; Start-Process fix.bat -Wait; Remove-Item fix.bat"
```

- It will download the script, execute it, and remove it
- Demonstration:

https://github.com/user-attachments/assets/e4301b83-46f7-4ce0-a508-51f3c3ce9919

#### Via the GUI

- [Click here](https://raw.githubusercontent.com/hirusha-adi/crowdstrike-fix/main/fix.bat) to download the file.
- Right click and Run as administrator.

![image](https://github.com/user-attachments/assets/19ce821a-3057-498f-9fd6-7a1647c2eab5)

- The script should work as intended.

![image](https://github.com/user-attachments/assets/9091a913-ab9c-4bb1-a083-aeac20fcf0db)

### Using the Powershell script

- If you dont want to use the ISO nor the batch script, you can use the Powershell script

#### One Liner

- NOTE that an internet connection is required to do this
- Open powershell as an administrator and run the command below

```ps1
iwr -useb https://raw.githubusercontent.com/hirusha-adi/crowdstrike-fix/main/fix.ps1 | iex
```
- It will download the script, execute it, and remove it
- Demonstration:

https://github.com/user-attachments/assets/692f218c-d8b7-4af6-9d53-b682eb7fcc90

## Manual Steps

## if BitLocker is not enabled.

1. Boot Windows into safe mode
2. Go to `C:\Windows\System32\drivers\CrowdStrike`
3. Delete files matching the `C-00000291*.sys` pattern
4. Reboot

### if BitLocker is enabled

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

## Development Guide

### What happens?

- `airootfs/root/.zlogin`
  - Make the ~/fix.sh executable and execute it.
- `airootfs/root/fix.sh`
  - Mount each volume.
  - Check if the `Windows\System32\drivers\CrowdStrike` directory exists,
    - if it exists, locate all the files matching `“C-00000291*.sys”` and delete them.
    - if it doesnt exist, continue to the next volume.
  - Unmount each volume.
  - Display a success message and shutdown.
- `airootfs/etc/motd`
  - the banner displayed to the user.

### Building the ISO(/Image)

- The image is based on `archiso` and you must use either Arch Linux or another distribution based on it (eg: EndeavourOS) to build the iso.

- The template is copied from `/usr/share/archiso/configs/releng/*` following the official documentation of `archiso`

```bash
# switch the user to root
su

# install build dependencies
pacman -S archiso

# go to files
cd ./archiso

# build the image with more verbosity
mkarchiso -v .

# work folder: ./work/
# output folder: ./out/

# after copying the output image, delete the files
rm -rf ./work
rm -rf ./out
```

- After this executes, you can find the iso file inside the `/archiso/out/` directory
