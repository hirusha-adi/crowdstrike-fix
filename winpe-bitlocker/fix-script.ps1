$KeyFilepath = "KeyList.csv"
$csvData = Import-Csv -Path $KeyFilepath

# CrowdStrike Update BSOD issue Fix by Tiraj Adikari - 22 July 2024
# Works also on Encrypted Drives (With a Key List)


# encrypted drives does not comes up in Get-PSDrive command   
try 
{
    $btlVolumes =	Get-BitLockerVolume   
    
    foreach($btlVolume in $btlVolumes) 
    {
        # drive is encrypted 
        # get key and then unlock

            Write-Host "Drive:  $btlVolume  is Encrypted.... Trying to decrypt."  -ForegroundColor red  
            $PCSerialNumber =  Get-CimInstance Win32_BIOS 
            $BitlockerKey = ""

            foreach ($line in $csvData) 
            {
                # Process each line here

                if ($PCSerialNumber.SerialNumber  -eq $line.'Serial')
                {
                    $BitlockerKey = $line.'Password'
                    Write-Host "Using Recovery Key : $BitlockerKey"    

                }
                 
            
            
            }

            if($BitlockerKey -ne "" )
            {
                if( Unlock-BitLocker -MountPoint "C:" -RecoveryPassword $BitlockerKey )
                {
                    Write-Host "$btlVolume  Drive Decrypted"  -ForegroundColor Green 
                }
                else 
                {
                    Write-Host "$btlVolume  Unable to decrypt the drive. Key  did not work"  -ForegroundColor red 
                }

            }
            else 
            {
                Write-Host "$btlVolume  Unable to decrypt the drive. Key not found."  -ForegroundColor red 
            }

            
           


    }

}
catch
{
    Write-Host $PSItem.Exception.Message  -ForegroundColor Green

}


# Once the drives are  decrypted , we can check them using Get-PSDrive
$drives =  Get-PSDrive -PSProvider FileSystem 


foreach($Drive in $drives) 
{

    $drivesize = ( [long]$Drive.Used   + [long]$Drive.Free )/(1024*1024*1024) 
    $CSFilepath = $Drive.Name +  ":\Windows\System32\drivers\CrowdStrike"
    $SystemPathforWindows = $Drive.Name +  ":\Windows\System32"
    $CSFile = $Drive.Name +  ":\Windows\System32\drivers\CrowdStrike\C-00000291*.sys"

    Write-Host "Working on Drive: $Drive , $drivesize GB " 
   

    if(Test-Path -Path $SystemPathforWindows  ) # Look for windows drive
    {
        

                # drive is open or decrypted 
                # Check if path exist
                if ( Test-Path -Path $CSFilepath  ) 
                {
                    Remove-Item  -Path $CSFile  -Force
                    Write-Host "File : C-00000291*.sys has been removed."  -ForegroundColor Green

                }
                else 
                {
                    Write-Host "CrowdStrike path is not available for the drive: $Drive"

                }


    } 
    else 
    {
        Write-Host "Drive: $Drive is not the system drive." 
    }
}


Write-Host  -ForegroundColor Yellow "Restarting  PC in 8 Seconds. Please remove the USB Drive" 
Start-Sleep -s 8
Restart-Computer