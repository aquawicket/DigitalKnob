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
		dk_validate DIGITALKNOB_DIR "dk_DIGITALKNOB_DIR"
		dk_set DKTOOLS_DIR "!DIGITALKNOB_DIR!\DKTools"
		if NOT exist "!DKTOOLS_DIR!" (
			dk_makeDirectory "!DKTOOLS_DIR!"
		)
	)
%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
    call dk_debugFunc 0
 ::setlocal
 
	::###### GET ######
	%dk_call% dk_DKTOOLS_DIR
    %dk_call% dk_printVar DKTOOLS_DIR
	
::	::###### SET ######
::	%dk_call% dk_DKTOOLS_DIR "C:\Dummy\DKTools"
::	%dk_call% dk_printVar DKTOOLS_DIR
::	
::	::###### GET ######
::	%dk_call% dk_DKTOOLS_DIR
::  %dk_call% dk_printVar DKTOOLS_DIR
::	
::	::###### SET ######
::	%dk_call% dk_DKTOOLS_DIR "C:\dk2\DKTools"
::	%dk_call% dk_printVar DKTOOLS_DIR
%endfunction%
