@echo off&::###### DK.cmd #########################################################################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


::############################################################################
::# dk_IpAddressPublic()
::#
::#
:dk_IpAddressPublic
%setlocal%
	%dk_call% dk_debugFunc 0
	
	for /f %%a in ('powershell Invoke-RestMethod api.ipify.org') do endlocal & (set dk_IpAddressPublic=%%a)

%endfunction%











::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0
	
	%dk_call% dk_IpAddressPublic
	%dk_call% dk_debug "dk_IpAddressPublic = %dk_IpAddressPublic%"
	
%endfunction%

