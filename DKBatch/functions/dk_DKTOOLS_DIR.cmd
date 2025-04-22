@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%A IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpA")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::#################################################################################################################################################


::####################################################################
::# dk_DKTOOLS_DIR()
::#
::#
:dk_DKTOOLS_DIR
::setlocal
	%dk_call% dk_debugFunc 0 1
 
	::############ SET ############
	if not "%~1" equ "" ( 
		set "DKTOOLS_DIR=%~1"
		%return%
	)
	
	::############ GET ############
	%dk_call% dk_validatePath DIGITALKNOB_DIR "%dk_call% dk_DIGITALKNOB_DIR"
	set "DKTOOLS_DIR=%DIGITALKNOB_DIR%/DKTools"
		
	if NOT exist "%DKTOOLS_DIR%" (%dk_call% dk_mkdir "%DKTOOLS_DIR%")
	
	%dk_call% dk_assertPath DIGITALKNOB_DIR
%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0

	%dk_call% dk_echo
	%dk_call% dk_echo "Test Getting DKTOOLS_DIR . . ."
	%dk_call% dk_DKTOOLS_DIR
	%dk_call% dk_echo "DKTOOLS_DIR = %DKTOOLS_DIR%"
	
	%dk_call% dk_echo
	%dk_call% dk_echo "Test Setting DKTOOLS_DIR . . ."
	%dk_call% dk_DKTOOLS_DIR "C:/DK/DKTools"
	%dk_call% dk_echo "DKTOOLS_DIR = %DKTOOLS_DIR%"
%endfunction%
