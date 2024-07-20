@echo off
setlocal

rem path to CrowdStrike folder
set "path=%WINDIR%\System32\drivers\CrowdStrike"

rem if the CrowdStrike folder exists
if exist "%path%" (
    echo Found CrowdStrike folder in %path%
    
    rem ls - before
    echo Listing contents before deletion:
    dir "%path%"
    
    rem delete all files matching C-00000291*.sys
    echo Deleting files matching C-00000291*.sys
    for %%F in ("%path%\C-00000291*.sys") do (
        echo Deleting: %%F
        del "%%F" /F
    )
    
    rem ls - after
    echo Listing contents after deletion:
    dir "%path%"
) else (
    echo CrowdStrike folder not found in %WINDIR%\System32\drivers
)

echo Script completed.
endlocal
pause
