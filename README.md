# Crowdstrike Fix

To fix the issue that arose in 7/19/2024. The fix is based on this [reddit post](https://www.reddit.com/r/crowdstrike/comments/1e6vmkf/comment/ldvxx62/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button).

## Limitations

This will not work if the volume in which the Windows installation exists is encrypted with BitLocker.

## Usage Guide

### Using the bootable image (incomplete)

- [Click here](#using-the-bootable-image-incomplete) to download the bootable image (which is based on Arch Linux) of size: `1.1GB`.
- Flash the image to a pendrive to make it bootable.
- Plug-in the bootable pendrive to your device and boot from it.
- Wait for it to load and fix the disk.
- Once fixed, your device will be shutdown automatically.
- You can then eject the pendrive and boot to Windows.
- TODO: Add images and video guides.

### Using the script

- If you are already booted into a Linux distribution, you can run the fix script directly,

```bash
# get the script
wget https://raw.githubusercontent.com/hirusha-adi/crowdstrike-fix/main/fix.sh

# make it executable
chmod +x fix.sh

# run the script
./fix.sh
```

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
