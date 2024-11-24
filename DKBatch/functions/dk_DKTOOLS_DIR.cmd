@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::####################################################################
::# dk_DKTOOLS_DIR()
::#
::#
:dk_DKTOOLS_DIR
    call dk_debugFunc 0 1
 ::setlocal enableDelayedExpansion
 
	::############ SET ############
	if "%~1" neq "" ( 
		dk_set DKTOOLS_DIR "%~1"

	rem ############ GET ############
	) else (
		%dk_call% dk_validate DIGITALKNOB_DIR "%dk_call% dk_DIGITALKNOB_DIR"
		%dk_call% dk_set DKTOOLS_DIR "!DIGITALKNOB_DIR!\DKTools"
	)
	
	if NOT exist "!DKTOOLS_DIR!" (
		dk_makeDirectory "!DKTOOLS_DIR!"
	)
%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
    call dk_debugFunc 0
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
