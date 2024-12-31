@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::####################################################################
::# dk_DKTOOLS_DIR()
::#
::#
:dk_DKTOOLS_DIR
    %dk_call% dk_debugFunc 0 1
 ::setlocal
 
	::############ SET ############
	if "%~1" neq "" ( 
		set "DKTOOLS_DIR=%~1"
		%return%
	)
	
	::############ GET ############
	%dk_call% dk_validatePath DIGITALKNOB_DIR "%dk_call% dk_DIGITALKNOB_DIR"
	set "DKTOOLS_DIR=%DIGITALKNOB_DIR%\DKTools"
		
	if NOT exist "%DKTOOLS_DIR%"    %dk_call% dk_makeDirectory "%DKTOOLS_DIR%"
	
	%dk_call% dk_assertPath DIGITALKNOB_DIR
%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
    %dk_call% dk_debugFunc 0
 setlocal
 
	%dk_call% dk_echo
	%dk_call% dk_echo "Test Getting DKTOOLS_DIR . . ."
	%dk_call% dk_DKTOOLS_DIR
	%dk_call% dk_printVar DKTOOLS_DIR
	
	%dk_call% dk_echo
	%dk_call% dk_echo "Test Setting DKTOOLS_DIR . . ."
	%dk_call% dk_DKTOOLS_DIR "C:\DK\DKTools"
	%dk_call% dk_printVar DKTOOLS_DIR 
%endfunction%
