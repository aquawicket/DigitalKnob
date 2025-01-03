@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::###############################################################################
::# dk_DKPLUGINS_DIR()
::#
::#
:dk_DKPLUGINS_DIR
	%dk_call% dk_debugFunc 0 1
	
	::############ SET ############
	if "%~1" neq "" ( 
		set "DKPLUGINS_DIR=%~1"
		%return%
	)

	::############ GET ############
	%dk_call% dk_validatePath DKBRANCH_DIR "%dk_call% dk_DKBRANCH_DIR"
	set "DKPLUGINS_DIR=%DKBRANCH_DIR%\DKPlugins"
	
	%dk_call% dk_assertPath DKPLUGINS_DIR
%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	setlocal
	%dk_call% dk_debugFunc 0
	
	%dk_call% dk_echo
	%dk_call% dk_echo "Test Getting DKPLUGINS_DIR . . ."
	%dk_call% dk_DKPLUGINS_DIR
	%dk_call% dk_printVar DKPLUGINS_DIR
	
	%dk_call% dk_echo
	%dk_call% dk_echo "Test Setting DKPLUGINS_DIR . . ."
	%dk_call% dk_DKPLUGINS_DIR "C:\DK\DKPlugins"
	%dk_call% dk_printVar DKPLUGINS_DIR 
%endfunction%
