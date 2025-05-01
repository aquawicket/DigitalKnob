@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::#################################################################################################################################################


::#####################################################################
::# dk_Host_Os()
::#
::#	  Host_Os = Android, Emscripten, Ios, Iossim, Linux, Mac, Raspberry, Windows
::#
:dk_Host_Os
%setlocal%
	%dk_call% dk_debugFunc 0 1

	rem ###### SET ######
	if "%~1" neq "" (
		set "Host_Os=%~1"
	
	rem ###### GET ######	
	) else (
		set "Host_Os=Win"
	)
	
	endlocal & (
		set "Host_Os=%Host_Os%"
		set "%Host_Os%_Host=1"
	)
%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0

	::###### GET ######
    %dk_call% dk_Host_Os
	%dk_call% dk_printVar Host_Os
	%dk_call% dk_printVar %Host_Os%_Host
	
	::###### SET ######
	%dk_call% dk_Host_Os "Windows"
	%dk_call% dk_printVar Host_Os
	%dk_call% dk_printVar %Host_Os%_Host
	
%endfunction%