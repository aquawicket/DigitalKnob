@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


::################################################################################
::# dk_getFullPath(path rtn_var)
::#
::#
:dk_getFullPath
%setlocal%
	%dk_call% dk_debugFunc 2

	set "_input_=%1"
	set "_input_=%_input_:"=%"
	if "%_input_:~-1%" equ "\" set "_input_=%_input_:~0,-1%"
	if "%_input_:~-1%" equ "/" set "_input_=%_input_:~0,-1%"
	endlocal & for %%Z in ("%_input_%") do set "%2=%%~fZ"
%endfunction%








::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0

	%dk_call% dk_set myPath "DK.cmd"
	%dk_call% dk_getFullPath "%myPath%" fullPath
	%dk_call% dk_printVar fullPath
%endfunction%
