# Fix using a WindowsPE Image

Supports Bitlocker Encryption?: No.

## Usage Guide

Versions:

- Bypass Version
  - Download: Click Here
  - Details: Script runs as `-ExecutionPolicy Bypass`
- Unrestricted Version
  - Download: Click Here
  - Details: Script runs as `-ExecutionPolicy Unrestricted`

1. Download the ISO file according to your need from the above section
2. Make your pendrive bootable with this file
3. Plug-in the bootable pendrive to your device and boot from it.
4. Wait for it to load and fix the disk.
5. Once the script has finished its execution, your device will be shutdown automatically.
6. You can then eject the pendrive and boot to Windows.

## Building the Image

### Setting up the envrionment

- Download and install the [Windows Assessment and Deployment Kit (ADK)](https://learn.microsoft.com/en-us/windows-hardware/get-started/adk-install) and matching WinPE add-on.

- For ADK versions prior to Windows 10, version 1809, WinPE is part of the ADK and isn't a separate add-on.

- Start the Deployment and Imaging Tools Environment as an administrator.

### Initial Setup

- Create a working copy of the Windows PE files

```
copype amd64 C:\WinPEImg
```

- Mount your WinPE image

```
Dism /Mount-Image /ImageFile:"C:\WinPEImg\media\sources\boot.wim" /Index:1 /MountDir:"C:\WinPEImg\mount"
```

### Add powershell

- Add powershell and it's dependencies

```
Dism /Add-Package /Image:"C:\WinPEImg\mount" /PackagePath:"C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Windows Preinstallation Environment\amd64\WinPE_OCs\WinPE-WMI.cab"
Dism /Add-Package /Image:"C:\WinPEImg\mount" /PackagePath:"C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Windows Preinstallation Environment\amd64\WinPE_OCs\en-us\WinPE-WMI_en-us.cab"
Dism /Add-Package /Image:"C:\WinPEImg\mount" /PackagePath:"C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Windows Preinstallation Environment\amd64\WinPE_OCs\WinPE-NetFX.cab"
Dism /Add-Package /Image:"C:\WinPEImg\mount" /PackagePath:"C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Windows Preinstallation Environment\amd64\WinPE_OCs\en-us\WinPE-NetFX_en-us.cab"
Dism /Add-Package /Image:"C:\WinPEImg\mount" /PackagePath:"C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Windows Preinstallation Environment\amd64\WinPE_OCs\WinPE-Scripting.cab"
Dism /Add-Package /Image:"C:\WinPEImg\mount" /PackagePath:"C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Windows Preinstallation Environment\amd64\WinPE_OCs\en-us\WinPE-Scripting_en-us.cab"
Dism /Add-Package /Image:"C:\WinPEImg\mount" /PackagePath:"C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Windows Preinstallation Environment\amd64\WinPE_OCs\WinPE-PowerShell.cab"
Dism /Add-Package /Image:"C:\WinPEImg\mount" /PackagePath:"C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Windows Preinstallation Environment\amd64\WinPE_OCs\en-us\WinPE-PowerShell_en-us.cab"
Dism /Add-Package /Image:"C:\WinPEImg\mount" /PackagePath:"C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Windows Preinstallation Environment\amd64\WinPE_OCs\WinPE-StorageWMI.cab"
Dism /Add-Package /Image:"C:\WinPEImg\mount" /PackagePath:"C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Windows Preinstallation Environment\amd64\WinPE_OCs\en-us\WinPE-StorageWMI_en-us.cab"
Dism /Add-Package /Image:"C:\WinPEImg\mount" /PackagePath:"C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Windows Preinstallation Environment\amd64\WinPE_OCs\WinPE-DismCmdlets.cab"
Dism /Add-Package /Image:"C:\WinPEImg\mount" /PackagePath:"C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Windows Preinstallation Environment\amd64\WinPE_OCs\en-us\WinPE-DismCmdlets_en-us.cab"
```

### Setup startup script

- Open target System32 folder

```
explorer C:\WinPEImg\mount\Windows\System32
```

- Update `startnet.cmd` to:

```
wpeinit
powershell.exe -ExecutionPolicy Bypass -File .\fix-script.ps1
```

- Copy the `fix-script.ps1` to that same directory

### Build the image

- Save the changes and unmount the image

```
Dism /Unmount-Image /MountDir:C:\WinPEImg\mount /Commit
```

- Build the ISO

```
MakeWinPEMedia /ISO C:\WinPEImg C:\WinPEImg\WinPE_ISO.iso
```

### Errors

- Incase if something fails (eg: failed to unmount), you can discard the mounted images manually:

  - list currently all mounted images

  ```
  dism /Get-MountedWimInfo
  ```

  - discard them manually

  ```
  dism /Unmount-Wim /MountDir:"C:\path\to\mount\directory" /Discard
  ```

  - examples (discarding):

  ```
  dism /Unmount-Wim /MountDir:"F:\$RECYCLE.BIN\S-1-5-21-2354160538-1415017437-1919434616-1001\$RLCKGKP\mount" /Discard
  dism /Unmount-Wim /MountDir:"F:\winpe\mount" /Discard
  ```

  - cleanup the dism Environment

  ```
  dism /Cleanup-Wim
  ```

  - and now, you can retry

## References

- https://learn.microsoft.com/en-us/windows-hardware/manufacture/desktop/winpe-adding-powershell-support-to-windows-pe?view=windows-11
- https://stackoverflow.com/questions/10906990/winpe-auto-scripts
