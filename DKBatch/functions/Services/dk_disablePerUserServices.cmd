@echo off&::###### DK.cmd #########################################################################################################################
if NOT exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if NOT defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


::############################################################################
::# dk_disablePerUserServices()
::#
::#
:dk_disablePerUserServices
%setlocal%
	%dk_call% dk_debugFunc 0

	for /f "tokens=2" %%G in ('sc query state^=all type^=userservice ^| find "SERVICE_NAME"') do (
		%dk_call% dk_registrySetKey "HKLM\SYSTEM\ControlSet001\Services\%%G" 		"UserServiceFlags" "REG_DWORD" "0"
		%dk_call% dk_registrySetKey "HKLM\SYSTEM\CurrentControlSet\Services\%%G" 	"UserServiceFlags" "REG_DWORD" "0"
	)

	%dk_call% dk_notice "Restart for changes to take effect"
%endfunction%











::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0
	
	%dk_call% dk_disablePerUserServices
%endfunction%

