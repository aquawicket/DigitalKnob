@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::###############################################################################
::# dk_DKAPPS_DIR()
::#
::#
:dk_DKAPPS_DIR
::setlocal
	%dk_call% dk_debugFunc 0 1
	
	if "%~1" neq "" (
		set "DKAPPS_DIR=%~1"
		%return%
	)
	
	%dk_call% dk_validate DKBRANCH_DIR "%dk_call% dk_DKBRANCH_DIR"
	::set "DKAPPS_DIR=%DKBRANCH_DIR%\DKApps"
	set "DKAPPS_DIR=%DKBRANCH_DIR%/DKApps"
	
	%dk_call% dk_assertPath DKAPPS_DIR
%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0
 
	%dk_call% dk_echo
	%dk_call% dk_echo "Test Getting DKAPPS_DIR . . ."
	%dk_call% dk_DKAPPS_DIR
	%dk_call% dk_printVar DKAPPS_DIR
	
	%dk_call% dk_echo
	%dk_call% dk_echo "Test Setting DKAPPS_DIR . . ."
	%dk_call% dk_DKAPPS_DIR "C:/DK/DKApps"
	%dk_call% dk_printVar DKAPPS_DIR 
%endfunction%
