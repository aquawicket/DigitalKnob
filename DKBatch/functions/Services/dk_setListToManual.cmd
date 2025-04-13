@echo off
if not defined DKBATCH_FUNCTIONS_DIR_ (set "DKBATCH_FUNCTIONS_DIR_=%CD:\=/%/../")
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%A IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpA")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)


::############################################################################
::# dk_setListToManual(list_file)
::#
::#
:dk_setListToManual
setlocal
	%dk_call% dk_debugFunc 1
	
	set "list_file=%~1"
	
	:: loop through services_MyList.txt, set to manual(demand)
	:: https://superuser.com/a/607582/600216
	:: also via registry   HKLM\SYSTEM\CurrentControlSet\Services\
	:: All services can be set to manual by changing their start field to 3
	:: reg add HKLM\SYSTEM\CurrentControlSet\Services\AarSvc_31cf0 /t REG_DWORD /v Start /d 3 /f
	:: reg add HKLM\SYSTEM\CurrentControlSet\Services\diagnosticshub.standardcollector.service /t REG_DWORD /v Start /d 3 /f

	echo #### Windows Services ####
	for /f "tokens=*" %%a in ("%list_file%") do (
		echo %%a 
		sc stop %%a 
		sc config "%%a" start=demand
		reg add HKLM\SYSTEM\CurrentControlSet\Services\%%a /t REG_DWORD /v Start /d 3 /f
	)
%endfunction%


















::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0

	%dk_call% dk_setListToManual "service_MyList.txt"
%endfunction%