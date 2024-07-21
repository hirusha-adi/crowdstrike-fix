# Arch Linux based ISO to fix CrowdStrike

Directory: `archiso`

Supports Bitlocker Encryption?: No

Demonstration: [Youtube Video](https://youtu.be/UnnPh6e8-dY)

Summary:

- A bootable image based on Arch Linux (made with archiso) that will run a fix script once booted into it and restart the computer automatically

## FAILED - DO NOT USE THIS!

This does not function as intended due to issues with mounting the NFTS volume.

Once the archiso loads, it will start executing the script automatically, and fail at moutning NTFS drives sometimes (i dont know why and when it excatly happens) and then, when you go to mount back the drive, it fails.

TODO: Paste images here.

## Usage Guide

- [Click here](#arch-linux-based-iso-to-fix-crowdstrike) to download the bootable image (which is based on Arch Linux) of size: `1.1GB`.
- Flash the image to a pendrive to make it bootable.
- Plug-in the bootable pendrive to your device and boot from it.
- Wait for it to load and fix the disk.
- Once the script has finished its execution, your device will be shutdown automatically.
- You can then eject the pendrive and boot to Windows.

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
cd archiso

# build the image with more verbosity
mkarchiso -v .

# work folder: archiso/work/
# output folder: archiso/out/

# after copying the output image, delete the files
rm -rf ./work
rm -rf ./out
```

- After this executes, you can find the iso file inside the `archiso/out/` directory
