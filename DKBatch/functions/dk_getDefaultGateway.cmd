@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::#################################################################################################################################################


::################################################################################
::# dk_getDefaultGateway(rtn_var)
::#
::#
:dk_getDefaultGateway
setlocal
	%dk_call% dk_debugFunc 1
	::for /f "tokens=2,3 delims={,}" %%a in ('"WMIC NICConfig where IPEnabled="True" get DefaultIPGateway /value | find "I" "') do echo IPv4 %%~a IPV6 %%~b
	for /f "tokens=2,3 delims={,}" %%a in ('"WMIC NICConfig where IPEnabled="True" get DefaultIPGateway /value | find "I" "') do set "rtn_value=%%~a"

	for %%a in (%*) do set last_arg=%%a
	if "%last_arg%" equ "rtn_var" (endlocal & set "%last_arg%=%rtn_value%" && echo %rtn_value%)
%endfunction%




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0

	%dk_call% dk_getDefaultGateway rtn_var
	%dk_call% dk_printVar rtn_var
%endfunction%
