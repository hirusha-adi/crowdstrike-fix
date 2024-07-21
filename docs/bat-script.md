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
powershell -Command "Invoke-WebRequest -Uri https://raw.githubusercontent.com/hirusha-adi/crowdstrike-fix/main/fix.bat -OutFile fix.bat; Start-Process fix.bat -Wait; Remove-Item fix.bat"
```

- It will download the script, execute it, and remove it

## Via the GUI

- [Click here](https://raw.githubusercontent.com/hirusha-adi/crowdstrike-fix/main/fix.bat) to download the file.
- Right click and Run as administrator.

![image](https://github.com/user-attachments/assets/19ce821a-3057-498f-9fd6-7a1647c2eab5)

- The script should work as intended.

![image](https://github.com/user-attachments/assets/9091a913-ab9c-4bb1-a083-aeac20fcf0db)
