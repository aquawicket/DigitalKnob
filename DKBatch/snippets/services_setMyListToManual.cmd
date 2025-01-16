:: loop through services_MyList.txt, set to manual(demand)
:: https://superuser.com/a/607582/600216
:: also via registry   HKLM\SYSTEM\CurrentControlSet\Services\
:: All services can be set to manual by changing their start field to 3
:: reg add HKLM\SYSTEM\CurrentControlSet\Services\AarSvc_31cf0 /t REG_DWORD /v Start /d 3 /f
:: reg add HKLM\SYSTEM\CurrentControlSet\Services\diagnosticshub.standardcollector.service /t REG_DWORD /v Start /d 3 /f
@echo off

echo #### Windows Services ####
for /f "tokens=*" %%a in (service_MyList.txt) do (
	echo %%a 
	sc stop %%a 
	sc config "%%a" start=demand
	reg add HKLM\SYSTEM\CurrentControlSet\Services\%%a /t REG_DWORD /v Start /d 3 /f
)
