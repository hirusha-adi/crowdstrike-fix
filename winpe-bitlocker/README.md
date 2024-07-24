# Fix using a WindowsPE Image

Credits: [Tiraj Adikari](https://www.linkedin.com/in/tiraj-adikari-a1686229/?originalSubdomain=au)

Supports Bitlocker Encryption?: Yes.

Demonstration: [Youtube](https://www.youtube.com/watch?v=eIsE5G4tihY)

![image](https://github.com/user-attachments/assets/3e184bde-9627-4d41-b8e4-33a86da339fd)

## Usage Guide

1. Export BitcLoker keys from the Active Directory ([click here](#exporting-bitlocker-keys)).
2. Build the Windows PE Image ([click here](#building-the-image)).
3. Make your pendrive bootable with this file.
4. Plug-in the bootable pendrive to your device and boot from it.
5. Wait for it to load and fix the disk.
6. Once the script has finished its execution, your device will be shutdown automatically.
7. You can then eject the pendrive and boot to Windows.

## Exporting BitLocker keys

- Execute the `export-keys-from-ad.ps1` script and export the bitcloker keys from the Active Directory

```
powershell.exe  -ExecutionPolicy Unrestricted  -file export-keys-from-ad.ps1
```

- The `.csv` file will be saved at: `C:\bitlocker-list.csv`

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

### Add BitLocker support

- Add BitLocker support and it's dependencies

```
Dism /Image:"C:\WinPEImg\mount" /Add-Package /PackagePath:"C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Windows Preinstallation Environment\amd64\WinPE_OCs\WinPE-WMI.cab"
Dism /Image:"C:\WinPEImg\mount" /add-package /packagepath:"C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Windows Preinstallation Environment\amd64\WinPE_OCs\en-us\WinPE-WMI_en-us.cab"
Dism /Image:"C:\WinPEImg\mount" /Add-Package /PackagePath:"C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Windows Preinstallation Environment\amd64\WinPE_OCs\WinPE-NetFx.cab"
Dism /Image:"C:\WinPEImg\mount" /add-package /packagepath:"C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Windows Preinstallation Environment\amd64\WinPE_OCs\en-us\WinPE-NetFx_en-us.cab"
Dism /Image:"C:\WinPEImg\mount" /add-package /packagepath:"C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Windows Preinstallation Environment\amd64\WinPE_OCs\WinPE-EnhancedStorage.cab"
Dism /Image:"C:\WinPEImg\mount" /add-package /packagepath:"C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Windows Preinstallation Environment\amd64\WinPE_OCs\en-us\WinPE-EnhancedStorage_en-us.cab"
Dism /Image:"C:\WinPEImg\mount" /add-package /packagepath:"C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Windows Preinstallation Environment\amd64\WinPE_OCs\WinPE-Scripting.cab"
Dism /Image:"C:\WinPEImg\mount" /add-package /packagepath:"C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Windows Preinstallation Environment\amd64\WinPE_OCs\en-us\WinPE-Scripting_en-us.cab"
Dism /Image:"C:\WinPEImg\mount" /add-package /packagepath:"C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Windows Preinstallation Environment\amd64\WinPE_OCs\WinPE-FMAPI.cab"
Dism /Image:"C:\WinPEImg\mount" /add-package /packagepath:"C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Windows Preinstallation Environment\amd64\WinPE_OCs\WinPE-SecureStartup.cab"
Dism /Image:"C:\WinPEImg\mount" /add-package /packagepath:"C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Windows Preinstallation Environment\amd64\WinPE_OCs\en-us\WinPE-SecureStartup_en-us.cab"
```

### Add PowerShell

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

### Setup fix script

- Open target System32 folder

```
explorer C:\WinPEImg\mount\Windows\System32
```

- Copy and replace the `startnet.cmd` in the target System32 folder (you can also change the `-ExecutionPolicy` to `Unrestricted` or add any other arguments when autostarting the script my modifying this file).
- Copy the `fix-script.ps1` to the target System32 folder.
- Copy the [exported](#exporting-bitlocker-keys) bitlocker keys at `C:\bitlocker-list.csv` to the target System32 folder.

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
- https://medium.com/@dbilanoski/how-to-get-bitlocker-recovery-passwords-from-active-directory-using-powershell-with-30a93e8dd8f2
- https://lazyexchangeadmin.cyou/bitlocker-winpe/
- https://stackoverflow.com/questions/77462449/how-to-get-bitlocker-recovery-keys-for-intune-device-with-ms-graph
- https://learn.microsoft.com/en-us/windows-hardware/manufacture/desktop/winpe-adding-powershell-support-to-windows-pe?view=windows-11
