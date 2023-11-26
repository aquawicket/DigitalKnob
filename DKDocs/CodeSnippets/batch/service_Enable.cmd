@echo off
%dkbatch%

set "SERVICE_NAME=schedule"     
::Put name here --^


reg add HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\%SERVICE_NAME% /t REG_DWORD /v Start /d 3 /f
sc config "%SERVICE_NAME%" start=auto
echo "Press any key to start the service"
pause
sc start %SERVICE_NAME%
