@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%A IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpA")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::#################################################################################################################################################


::####################################################################
::# dk_nativePath(<pathname>, <rtn_var>:optional)
::#
::#
:dk_nativePath
setlocal
	%dk_call% dk_debugFunc 1 2

    set pathname=%1
    set pathname=%pathname:"=%
	set "pathname=%pathname:/=\%"
    if "%pathname:~-1%" equ "\" set pathname=%pathname:~0,-1%

	for %%Z in ("%pathname%") do set "dk_nativePath=%%~fZ"
::	set "dk_nativePath=%dk_nativePath:\=/%"
	
    endlocal & (
		set "dk_nativePath=%dk_nativePath%"
		if "%~2" neq "" (set "%~2=%dk_nativePath%")
	)	

%endfunction%




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0

    %dk_call% dk_set myPath "C:/Windows/System32"
    %dk_call% dk_nativePath "%myPath%" nativePath
    %dk_call% dk_printVar nativePath
%endfunction%
