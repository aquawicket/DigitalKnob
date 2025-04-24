@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::#################################################################################################################################################


::################################################################################
::# dk_getPath(<path>, <rtn_var>:optional)
::#
::#    reference: https://stackoverflow.com/a/59739663/688352
::#
:dk_getPath
setlocal
	%dk_call% dk_debugFunc 1 2

    set "_input=%1"
    set "_input=%_input:"=%"
	set "_input=%_input:/=\%"
    if "%_input:~-1%" equ "\" (set "_input=%_input:~0,-1%")
    for %%Z in ("%_input%") do (set "dk_getPath=%%~pZ")
	if "%dk_getPath:~-1%" equ "\" (set "dk_getPath=%dk_getPath:~0,-1%")
	
    endlocal & (
		set "dk_getPath=%dk_getPath:\=/%"
		if "%~2" neq "" (set "%~2=%dk_getPath:\=/%")
	)
%endfunction%



::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0

	%dk_call% dk_set myPath "DK.cmd"
    %dk_call% dk_getPath "%myPath%"
    %dk_call% dk_printVar dk_getPath
%endfunction%
