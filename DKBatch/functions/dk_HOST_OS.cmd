@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::#################################################################################################################################################


::#####################################################################
::# dk_HOST_OS()
::#
::#	  host_os = android, emscripten, ios, iossim, linux, mac, raspberry, windows
::#
:dk_HOST_OS
setlocal enableDelayedExpansion
	%dk_call% dk_debugFunc 0 1

	rem ###### SET ######
	if "%~1" neq "" (
		set "host_os=%~1"
	
	rem ###### GET ######	
	) else (
		set "host_os=win"
	)
	
	endlocal & (
		set "host_os=%host_os%"
		set "%host_os%_host=1"
	)
%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0

	::###### GET ######
    %dk_call% dk_HOST_OS
	%dk_call% dk_printVar host_os
	%dk_call% dk_printVar %host_os%_host
	
	::###### SET ######
	%dk_call% dk_HOST_OS "windows"
	%dk_call% dk_printVar host_os
	%dk_call% dk_printVar %host_os%_host
	
%endfunction%