@rem shebang
@echo off&rem ###### DK.cmd #########################################################################################################################
if not defined DKINIT_cmd (
	setlocal enableDelayedExpansion
	if NOT EXIST "%DK.cmd%" (set "DK.cmd=%USERPROFILE%\Digital Knob\Development\DKBatch\functions\DK.cmd")
	if NOT DEFINED DK.cmd (for /F "delims=" %%G IN ('dir /b/s/a:-d "%USERPROFILE%\DK.cmd"') do (set "DK.cmd=%%~fG"))
	if NOT EXIST "!DK.cmd!" (
		start "" /b /wait /min "curl.exe" --silent --location --create-dirs --output "!DK.cmd!" http://aquawicket.com/DigitalKnob/Development/DKBatch/functions/DK.cmd)
	call "!DK.cmd:/=\!" "%%~0" %%*
	exit /b %errorlevel%
)
rem #################################################################################################################################################


rem ############################################################################
rem # Services/dk_createListFiles()
rem #
rem #
:dk_createListFiles
%setlocal%
	
	rem echo #### Windows Services ####
	rem sc query
	rem sc query > services_running.txt
	rem sc query state= all > services_all.txt
	echo.
	%dk_call% dk_debug "### services_running.txt ###"
	del "services_running.txt" 1>nul 2>nul
	for /f "tokens=2" %%G in ('sc query ^| find "SERVICE_NAME"') do >>services_running.txt echo %%G
	type "services_running.txt"

	echo.
	%dk_call% dk_debug "### services_service.txt ###"
	del "services_service.txt" 1>nul 2>nul
	for /f "tokens=2" %%G in ('sc query state^=all type^=service ^| find "SERVICE_NAME"') do echo %%G >> "services_service.txt"
	type "services_service.txt"

	echo.
	%dk_call% dk_debug "### services_user.txt ###"
	del "services_user.txt" 1>nul 2>nul
	for /f "tokens=2" %%G in ('sc query state^=all type^=userservice ^| find "SERVICE_NAME"') do echo %%G >> "services_user.txt"
	type "services_user.txt"
	
	echo.
	%dk_call% dk_debug "### services_driver.txt ###"
	del "services_driver.txt" 1>nul 2>nul
	for /f "tokens=2" %%G in ('sc query state^=all type^=driver ^| find "SERVICE_NAME"') do echo %%G >> "services_driver.txt"
	type "services_driver.txt"
	
	echo.
	%dk_call% dk_debug "### services_all.txt ###"
	del "services_all.txt" 1>nul 2>nul
	for /f "tokens=2" %%G in ('sc query state^=all type^=all ^| find "SERVICE_NAME"') do echo %%G >> "services_all.txt"
	type "services_all.txt"
	
	echo.
	%dk_call% dk_debug "### services_everything.txt ###"
	del "services_everything.txt" 1>nul 2>nul
	for /f "tokens=*" %%G in ('sc queryex state^=all type^=all') do echo %%G >> "services_everything.txt"
	type "services_everything.txt"
%endfunction%


















rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

	%dk_call% Services/dk_createListFiles
%endfunction%