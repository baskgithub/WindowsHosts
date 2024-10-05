@echo off
echo Downloading hosts file...
powershell -Command "Invoke-WebRequest -Uri 'https://raw.hellogithub.com/hosts' -OutFile '%TEMP%\hosts'"
echo Download complete.

echo Overwriting the original hosts file...
copy /Y "%TEMP%\hosts" "C:\Windows\System32\drivers\etc\hosts"
echo Overwrite complete.

ipconfig /flushdns

echo All done!
pause
