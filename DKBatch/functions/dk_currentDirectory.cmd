@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::#################################################################################################################################################


::################################################################################
::# dk_currentDirectory(optional:<rtn_var>)
::#
::#	REFERENCE: https://ss64.com/nt/syntax-gettime.html
::#
:dk_currentDirectory
setlocal
	%dk_call% dk_debugFunc 1
	set "dk_currentDirectory=%CD%"

	endlocal & (
		set "dk_currentDirectory=%dk_currentDirectory%"
		if "%~1" neq "" (set "%~1=%dk_currentDirectory%")
	)
%endfunction%





::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0

	%dk_call% dk_currentDirectory
	%dk_call% dk_printVar dk_currentDirectory

	%dk_call% dk_currentDirectory myPath
	%dk_call% dk_printVar myPath
	%dk_call% dk_printVar dk_currentDirectory
%endfunction%
