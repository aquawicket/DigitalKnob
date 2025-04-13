@echo off
if not defined DKBATCH_FUNCTIONS_DIR_ (set "DKBATCH_FUNCTIONS_DIR_=%CD:\=/%/../")
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%A IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpA")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)


::############################################################################
::# dk_createListFiles()
::#
::#
:dk_createListFiles
setlocal
	%dk_call% dk_debugFunc 0
	
	::echo #### Windows Services ####
	::sc query
	::sc query > services_running.txt
	::sc query state= all > services_all.txt
	echo. > services_running.txt
	for /f "tokens=2" %%s in ('sc query ^| find "SERVICE_NAME"') do echo %%s >> services_running.txt


	echo. > services_all.txt
	for /f "tokens=2" %%s in ('sc query state^= all ^| find "SERVICE_NAME"') do echo %%s >> services_all.txt
%endfunction%


















::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0

	%dk_call% dk_createListFiles
%endfunction%