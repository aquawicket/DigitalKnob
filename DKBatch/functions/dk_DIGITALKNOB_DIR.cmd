@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::#################################################################################################################################################


::####################################################################
::# dk_DIGITALKNOB_DIR()
::#
::#
:dk_DIGITALKNOB_DIR
::%setlocal%
	%dk_call% dk_debugFunc 0 1
    
	::############ SET ############
	if "%~1" neq "" ( 
		set "DIGITALKNOB_DIR=%~1"
		%return%
	)
	
	::############ GET ############
    ::if not defined DIGITALKNOB        (set "DIGITALKNOB=D i g i t a l K n o b")
    if not defined DIGITALKNOB          (set "DIGITALKNOB=digitalknob")
    
	::### DIGITALKNOB_DIR ###
	%dk_call% dk_validatePath DKHOME_DIR    "%dk_call% dk_DKHOME_DIR"
	set "DIGITALKNOB_DIR=%DKHOME_DIR%/%DIGITALKNOB%"
    if not exist "%DIGITALKNOB_DIR%" (%dk_call% dk_mkdir "%DIGITALKNOB_DIR%")

	%dk_call% dk_assertPath DIGITALKNOB_DIR
%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0
  
	%dk_call% dk_echo
	%dk_call% dk_echo "Test Getting DIGITALKNOB_DIR . . ."
	%dk_call% dk_DIGITALKNOB_DIR
	%dk_call% dk_echo "DIGITALKNOB_DIR = %DIGITALKNOB_DIR%"
	
	%dk_call% dk_echo
	%dk_call% dk_echo "Test Setting DIGITALKNOB_DIR . . ."
	%dk_call% dk_DIGITALKNOB_DIR "C:/digitalknob"
	%dk_call% dk_echo "DIGITALKNOB_DIR = %DIGITALKNOB_DIR%"
%endfunction%
