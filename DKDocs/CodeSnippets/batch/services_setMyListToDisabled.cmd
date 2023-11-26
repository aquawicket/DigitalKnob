:: loop through services_MyList.txt, stop and diable any service in the list
@echo off
%dkbatch%

echo #### Windows Services ####
for /f "tokens=*" %%a in (services_MyList.txt) do (
	echo %%a
	sc stop %%a
	sc config "%%a" start=disabled
	reg add HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\%%a /t REG_DWORD /v Start /d 4 /f
)


:: https://superuser.com/a/607582/600216
:: also via registry   HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\
:: All services can be disabled by changing their start field to 4
:: reg add HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\AarSvc_31cf0 /t REG_DWORD /v Start /d 4 /f
:: reg add HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\diagnosticshub.standardcollector.service /t REG_DWORD /v Start /d 4 /f
