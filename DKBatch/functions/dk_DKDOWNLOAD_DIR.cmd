@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::####################################################################
::# dk_DKDOWNLOAD_DIR()
::#
::#
:dk_DKDOWNLOAD_DIR
    call dk_debugFunc 0 1
 ::setlocal enableDelayedExpansion
 
	::############ SET ############
	if "%~1" neq "" ( 
		set "DKDOWNLOAD_DIR=%~1"
		%return%
	)

	::############ GET ############
	%dk_call% dk_validatePath DIGITALKNOB_DIR "%dk_call% dk_DIGITALKNOB_DIR"
	set "DKDOWNLOAD_DIR=%DIGITALKNOB_DIR%\download"
	if NOT exist "%DKDOWNLOAD_DIR%"   %dk_call% dk_makeDirectory "%DKDOWNLOAD_DIR%"
	
	%dk_call% dk_assertPath DKDOWNLOAD_DIR
%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
    call dk_debugFunc 0
 setlocal
 
	%dk_call% dk_echo
	%dk_call% dk_echo "Test Getting DKDOWNLOAD_DIR . . ."
	%dk_call% dk_DKDOWNLOAD_DIR
	%dk_call% dk_printVar DKDOWNLOAD_DIR
	
	%dk_call% dk_echo
	%dk_call% dk_echo "Test Setting DKDOWNLOAD_DIR . . ."
	%dk_call% dk_DKDOWNLOAD_DIR "C:\DK\download"
	%dk_call% dk_printVar DKDOWNLOAD_DIR 
%endfunction%