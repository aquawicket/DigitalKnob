@echo off
if not defined DKBATCH_FUNCTIONS_DIR_ (set "DKBATCH_FUNCTIONS_DIR_=%CD:\=/%/../")
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)

::############################################################################
::# dk_setListToDisabled(list_file)
::#
::#
:dk_setListToDisabled
setlocal enableDelayedExpansion
	%dk_call% dk_debugFunc 1
	
	:: loop through services_MyList.txt, stop and diable any service in the list
	set "list_file=%~1"

	echo #### Windows Services ####
	for /f "tokens=*" %%a in ("%list_file%") do (
		echo %%a
		sc stop %%a
		sc config "%%a" start=disabled
		reg add HKLM\SYSTEM\CurrentControlSet\Services\%%a /t REG_DWORD /v Start /d 4 /f
	)


	:: https://superuser.com/a/607582/600216
	:: also via registry   HKLM\SYSTEM\CurrentControlSet\Services\
	:: All services can be disabled by changing their start field to 4
	:: reg add HKLM\SYSTEM\CurrentControlSet\Services\AarSvc_31cf0 /t REG_DWORD /v Start /d 4 /f
	:: reg add HKLM\SYSTEM\CurrentControlSet\Services\diagnosticshub.standardcollector.service /t REG_DWORD /v Start /d 4 /f
%endfunction%


















::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0

	%dk_call% dk_setListToDisabled "services_MyList.txt"
%endfunction%