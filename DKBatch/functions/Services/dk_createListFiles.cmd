@echo off
if not defined DKBATCH_FUNCTIONS_DIR_ (set "DKBATCH_FUNCTIONS_DIR_=%CD:\=/%/../")
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)


::############################################################################
::# dk_createListFiles()
::#
::#
:dk_createListFiles
%setlocal%
	%dk_call% dk_debugFunc 0
	
	::echo #### Windows Services ####
	::sc query
	::sc query > services_running.txt
	::sc query state= all > services_all.txt
	echo( > services_running.txt
	for /f "tokens=2" %%G in ('sc query ^| find "SERVICE_NAME"') do echo %%G >> services_running.txt

	echo( > services_service.txt
	for /f "tokens=2" %%G in ('sc query state^=all type^=service ^| find "SERVICE_NAME"') do echo %%G >> services_service.txt
	
	echo( > services_user.txt
	for /f "tokens=2" %%G in ('sc query state^=all type^=userservice ^| find "SERVICE_NAME"') do echo %%G >> services_user.txt
	
	echo( > services_driver.txt
	for /f "tokens=2" %%G in ('sc query state^=all type^=driver ^| find "SERVICE_NAME"') do echo %%G >> services_driver.txt
	
	echo( > services_all.txt
	for /f "tokens=2" %%G in ('sc query state^=all type^=all ^| find "SERVICE_NAME"') do echo %%G >> services_all.txt
	
	echo( > services_everything.txt
	for /f "tokens=*" %%G in ('sc queryex state^=all type^=all') do echo %%G >> services_everything.txt

%endfunction%


















::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0

	%dk_call% dk_createListFiles
%endfunction%