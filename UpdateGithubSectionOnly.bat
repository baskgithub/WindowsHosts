@echo off
setlocal enabledelayedexpansion

set "url=https://raw.hellogithub.com/hosts"
set "tempfile=%temp%\remote-hosts"
set "hostsfile=C:\Windows\System32\drivers\etc\hosts"
set "string1=### Github Start"
set "string2=### Github End"
set "found1=0"
set "found2=0"
set "point1=0"
set "point2=0"

rem Download the remote-hosts file
powershell -Command "Invoke-WebRequest -Uri %url% -OutFile %tempfile%"

rem Read the hosts file and find the positions of the strings
for /f "tokens=1,* delims=:" %%a in ('findstr /n "^" %hostsfile%') do (
    if "!found1!"=="0" if "%%b"=="%string1%" (
        set "found1=1"
        set "point1=%%a"
    )
    if "!found2!"=="0" if "%%b"=="%string2%" (
        set "found2=1"
        set "point2=%%a"
    )
)

if "!found1!"=="0" (
    echo String "%string1%" not found in %hostsfile%
    copy /b %hostsfile% + %tempfile% C.txt
    goto :movefile
)
if "!found2!"=="0" (
    echo String "%string2%" not found in %hostsfile%
    copy /b %hostsfile% + %tempfile% C.txt
    goto :movefile
)

rem Split the hosts file into A1.txt and A2.txt
(for /f "tokens=1,* delims=:" %%a in ('findstr /n "^" %hostsfile%') do (
    if %%a leq !point1! echo(%%b
)) > A1.txt

(for /f "tokens=1,* delims=:" %%a in ('findstr /n "^" %hostsfile%') do (
    if %%a geq !point2! echo(%%b
)) > A2.txt

rem Concatenate A1.txt, remote-hosts, and A2.txt into C.txt
copy /b A1.txt + %tempfile% + A2.txt C.txt

:movefile
rem Move C.txt to overwrite the hosts file
move /y C.txt %hostsfile%

rem Refresh the DNS
ipconfig /flushdns

echo Hosts file has been updated successfully

endlocal
pause
