@echo off
setlocal enabledelayedexpansion

REM Step 1: Download the file
set "url=https://raw.hellogithub.com/hosts"
set "downloadedFile=%TEMP%\hosts_downloaded"
powershell -Command "(New-Object System.Net.WebClient).DownloadFile('%url%', '%downloadedFile%')"

REM Step 2: Open the hosts file and find marker lines
set "hostsFile=C:\Windows\System32\drivers\etc\hosts"
set "tempFile=%TEMP%\hosts_temp"
set "foundStart=0"
set "foundEnd=0"

if exist "%hostsFile%" (
    for /f "tokens=1,* delims=:" %%i in ('findstr /n "^" "%hostsFile%"') do (
        set "line=%%j"
        if "!line!"=="### Github Start" set "foundStart=1"
        if "!line!"=="### Github End" set "foundEnd=1"
    )
)

REM Step 3: Replace or append content based on marker lines
if %foundStart% equ 1 if %foundEnd% equ 1 (
    echo Replacing content between marker lines...
    (
        set "skip="
        for /f "tokens=1,* delims=:" %%i in ('findstr /n "^" "%hostsFile%"') do (
            set "line=%%j"
            if "!line!"=="### Github Start" (
                echo !line!
                for /f "delims=" %%k in ('type "%downloadedFile%"') do (
                    if "%%k"=="" (
                        echo.
                    ) else (
                        echo %%k
                    )
                )
                set "skip=1"
            ) else if "!line!"=="### Github End" (
                echo !line!
                set "skip="
            ) else if not defined skip (
                if "!line!"=="" (
                    echo.
                ) else (
                    echo !line!
                )
            )
        )
    ) > "%tempFile%"
) else (
    echo Marker lines not found, appending content...
    type "%hostsFile%" > "%tempFile%"
    echo. >> "%tempFile%"
    for /f "delims=" %%k in ('type "%downloadedFile%"') do (
        if "%%k"=="" (
            echo.
        ) else (
            echo %%k
        )
    )
)

REM Step 4: Save the new file
move /y "%tempFile%" "%hostsFile%"

REM Step 5: Refresh the DNS
ipconfig /flushdns

echo Operation completed.
endlocal
pause
