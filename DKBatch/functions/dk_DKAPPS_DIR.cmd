@echo off
if not defined DKINIT (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*)

::###############################################################################
::# dk_DKAPPS_DIR()
::#
::#
:dk_DKAPPS_DIR
::setlocal
	%dk_call% dk_debugFunc 0 1
	
	if "%~1" neq "" (
		set "DKCPP_APPS_DIR=%~1"
		%return%
	)
	
	%dk_call% dk_validate DKBRANCH_DIR "%dk_call% dk_DKBRANCH_DIR"
	set "DKCPP_APPS_DIR=%DKBRANCH_DIR%/DKCpp/apps"
	
	%dk_call% dk_assertPath DKCPP_APPS_DIR
%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0
 
	%dk_call% dk_echo
	%dk_call% dk_echo "Test Getting DKCPP_APPS_DIR . . ."
	%dk_call% dk_DKAPPS_DIR
	%dk_call% dk_printVar DKCPP_APPS_DIR
	
	%dk_call% dk_echo
	%dk_call% dk_echo "Test Setting DKCPP_APPS_DIR . . ."
	%dk_call% dk_DKAPPS_DIR "C:/DK/apps"
	%dk_call% dk_printVar DKCPP_APPS_DIR 
%endfunction%
