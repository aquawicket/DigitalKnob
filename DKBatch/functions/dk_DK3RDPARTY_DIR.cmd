@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::#################################################################################################################################################


::###############################################################################
::# dk_DK3RDPARTY_DIR()
::#
::#
:dk_DK3RDPARTY_DIR
::setlocal
	%dk_call% dk_debugFunc 0 1
	
	if not "%~1" equ "" (
		set "DK3RDPARTY_DIR=%~1"
		%return%
	)
	
	%dk_call% dk_validate DKBRANCH_DIR "%dk_call% dk_DKBRANCH_DIR"
	set "DK3RDPARTY_DIR=%DKBRANCH_DIR%/3rdParty"
	
	::%dk_call% dk_assertPath DK3RDPARTY_DIR
%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0
	
	%dk_call% dk_echo
	%dk_call% dk_echo "Test Getting DK3RDPARTY_DIR . . ."
	%dk_call% dk_DK3RDPARTY_DIR
	%dk_call% dk_echo "DK3RDPARTY_DIR = %DK3RDPARTY_DIR%"
	
	%dk_call% dk_echo
	%dk_call% dk_echo "Test Setting DK3RDPARTY_DIR . . ."
	%dk_call% dk_DK3RDPARTY_DIR "C:/DK/3rdParty"
	%dk_call% dk_echo "DK3RDPARTY_DIR = %DK3RDPARTY_DIR%"
%endfunction%
