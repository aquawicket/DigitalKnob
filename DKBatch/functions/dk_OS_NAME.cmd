@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%A IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpA")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::#################################################################################################################################################


::############################################################################
::# dk_OS_NAME()
::#
::#
:dk_OS_NAME
setlocal
	%dk_call% dk_debugFunc 0

	for /f "tokens=1* delims==" %%A in ('wmic os get Caption /value') do (
	for /f "tokens=*" %%S in ("%%B") do (
		if "%%A" equ "Caption" set "OS_NAME=%%S"
	))
	
	endlocal & (
		set "OS_NAME=%OS_NAME%"
	)
)
%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0

	%dk_call% dk_OS_NAME
	echo OS_NAME = '%OS_NAME%'
%endfunction%
