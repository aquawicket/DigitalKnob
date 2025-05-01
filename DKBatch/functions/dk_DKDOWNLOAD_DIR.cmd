@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::#################################################################################################################################################


::####################################################################
::# dk_DKDOWNLOAD_DIR()
::#
::#
:dk_DKDOWNLOAD_DIR
::%setlocal%
	%dk_call% dk_debugFunc 0 1 
 
	::############ SET ############
	if "%~1" neq "" ( 
		set "DKDOWNLOAD_DIR=%~1"
		%return%
	)

	::############ GET ############
	%dk_call% dk_validatePath DIGITALKNOB_DIR "%dk_call% dk_DIGITALKNOB_DIR"
	set "DKDOWNLOAD_DIR=%DIGITALKNOB_DIR%/download"
	if NOT exist "%DKDOWNLOAD_DIR%" (%dk_call% dk_mkdir "%DKDOWNLOAD_DIR%")
	
	%dk_call% dk_assertPath DKDOWNLOAD_DIR
%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0

	%dk_call% dk_echo
	%dk_call% dk_echo "Test Getting DKDOWNLOAD_DIR . . ."
	%dk_call% dk_DKDOWNLOAD_DIR
	%dk_call% dk_echo "DKDOWNLOAD_DIR = %DKDOWNLOAD_DIR%"
	
	%dk_call% dk_echo
	%dk_call% dk_echo "Test Setting DKDOWNLOAD_DIR . . ."
	%dk_call% dk_DKDOWNLOAD_DIR "C:/DK/download"
	%dk_call% dk_echo "DKDOWNLOAD_DIR = %DKDOWNLOAD_DIR%"
%endfunction%
