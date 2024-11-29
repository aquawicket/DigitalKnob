@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::###############################################################################
::# dk_DK3RDPARTY_DIR()
::#
::#
:dk_DK3RDPARTY_DIR
	call dk_debugFunc 0 1
	
	if "%~1" neq "" (
		set "DK3RDPARTY_DIR=%~1"
		%return%
	)
	
	%dk_call% dk_validatePath DKBRANCH_DIR "%dk_call% dk_DKBRANCH_DIR"
	set "DK3RDPARTY_DIR=%DKBRANCH_DIR%\3rdParty"
	
	%dk_call% dk_assertPath DK3RDPARTY_DIR
%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc 0
	
	%dk_call% dk_echo
	%dk_call% dk_echo "Test Getting DK3RDPARTY_DIR . . ."
	%dk_call% dk_DK3RDPARTY_DIR
	%dk_call% dk_printVar DK3RDPARTY_DIR
	
	%dk_call% dk_echo
	%dk_call% dk_echo "Test Setting DK3RDPARTY_DIR . . ."
	%dk_call% dk_DK3RDPARTY_DIR "C:\DK\3rdParty"
	%dk_call% dk_printVar DK3RDPARTY_DIR 
%endfunction%
