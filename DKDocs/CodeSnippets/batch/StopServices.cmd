@ECHO OFF
:: loop through Services.txt, stop and diable any service in the list

echo #### Windows Services ####
for /F "tokens=*" %%A in (ServiceList.txt) do echo %%A & sc stop %%A & sc config "%%A" start=disabled & reg add HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\%%A /t REG_DWORD /v Start /d 4 /f

pause

:: https://superuser.com/a/607582/600216
:: also via registry   HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\
:: All services can be disabled by changing their start field to 4
:: reg add HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\AarSvc_31cf0 /t REG_DWORD /v Start /d 4 /f
:: reg add HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\diagnosticshub.standardcollector.service /t REG_DWORD /v Start /d 4 /f
