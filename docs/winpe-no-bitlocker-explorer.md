# Fix using a custom Windows ISO

Summary:

- A custom Windows image (made with [this tool](https://github.com/ChrisRfr/Win10XPE)) which will fix the issue and restart the computer

Directory: `winpe`

Supports Bitlocker Encryption?: No

Download ISO File: [Click here](https://drive.google.com/file/d/1DpG4rdgNYhquszO324B6rgw-LDlEMyzi/view?usp=sharing) (approx. 850MB) (this is based on the `install.wim` file of WIndows 10 Enteprise LTSC 2021)

Demonstration: [Youtube Video](https://youtu.be/2F-rhVMHQfE)

https://github.com/user-attachments/assets/e703600f-9b48-45be-8531-96a8018cc211

## Usage Guide

1. [Click here](https://drive.google.com/file/d/1DpG4rdgNYhquszO324B6rgw-LDlEMyzi/view?usp=sharing) to download the ISO file
2. Make your pendrive bootable with this file
3. Plug-in the bootable pendrive to your device and boot from it.
4. Wait for it to load and fix the disk.
5. Once the script has finished its execution, your device will be shutdown automatically.
6. You can then eject the pendrive and boot to Windows.

## Development Guide

### Building the Image

- Mount your original windows 10 iso file

![WhatsApp Image 2024-07-21 at 14 38 43_01dd9311](https://github.com/user-attachments/assets/4659d40e-687c-4707-b82c-bd077ef07b1a)

- Download [this tool](https://github.com/ChrisRfr/Win10XPE), extract it and set it up, and run it as an administrator

![WhatsApp Image 2024-07-21 at 14 39 05_be864aa0](https://github.com/user-attachments/assets/4aec23c0-0ba3-4bf8-ad06-b130046c5137)

- Click on Select Source Folder

![WhatsApp Image 2024-07-21 at 14 39 18_3d7d88b3](https://github.com/user-attachments/assets/b9685c86-fc99-4a51-82a7-990384e0a2d4)

- And select the mounted original windows volume

![WhatsApp Image 2024-07-21 at 14 39 37_f684ba08](https://github.com/user-attachments/assets/4210ad24-1aba-4442-9730-686c20973cfb)

- Come to the Source tab in the Build Core section and set the Source Directory to a drive with atleast 10GB of free storage

![WhatsApp Image 2024-07-21 at 14 42 27_e7b25121](https://github.com/user-attachments/assets/f20b4295-eef1-4159-ad78-8a92c7bb5fb2)

- Come back to the Script section and under Main Interface, update the settings and displayed here, enable "Add Your Custom Folder", and click on "Open Custom Folder", 

![WhatsApp Image 2024-07-21 at 14 40 52_f9e35187](https://github.com/user-attachments/assets/0e9a624e-a0f3-47e5-87ab-93dcff139277)

- Update the files as required, you can copy the files in the `winpe` directory if this github repository to it, you can also go to upper levels of this directory and find the Wallpapers directory, this is where you can update the Wallpaper

![WhatsApp Image 2024-07-21 at 14 41 03_914c2f50](https://github.com/user-attachments/assets/2d34d0b5-1565-4ee1-9b11-620296e76127)

- Go to the Build Options section and update the settings as displayed here

![WhatsApp Image 2024-07-21 at 14 41 52_f30f2b8a](https://github.com/user-attachments/assets/f07a99ad-a263-45da-93cd-c22c750656f4)

- Expand the sidebar and go to Win10XPE -> Apps -> Components -> PowerShell Core and press on Launch to get the required files (approx 100MB) and test it

![WhatsApp Image 2024-07-21 at 14 40 02_72351536](https://github.com/user-attachments/assets/9148ee98-ecf3-4260-8530-e4976774fb3b)

- You can now come to the Create ISO section in the sidebar, set the settings to whats displayed here and press on "Play" to start building the image

![WhatsApp Image 2024-07-21 at 14 42 39_1aa38551](https://github.com/user-attachments/assets/70758c3a-0913-4891-a613-179c895abb32)

- Wait for it to complete,

![WhatsApp Image 2024-07-21 at 14 46 41_7e274e17](https://github.com/user-attachments/assets/a465c457-ca5a-4862-a697-91221f5fe866)

- You should now find your `Win10XPE_x64.iso` inside the same directory with `Win10XPE.exe`

