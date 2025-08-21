@echo off&::###### DK.cmd #########################################################################################################################
if NOT defined DKBATCH_FUNCTIONS_DIR_ (set DKBATCH_FUNCTIONS_DIR_=%USERPROFILE%/DigitalKnob/Development/DKBatch/functions/)
if NOT EXIST "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if NOT defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
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
    ::if NOT defined DIGITALKNOB        		(set "DIGITALKNOB=D i g i t a l K n o b")
    if NOT defined DIGITALKNOB          		(set "DIGITALKNOB=DigitalKnob")
	if NOT defined DKHTTP_DIGITALKNOB         	(set "DKHTTP_DIGITALKNOB=DigitalKnob")
   
	::### DIGITALKNOB_DIR ###
	%dk_call% dk_validatePath DKHOME_DIR	"%dk_call% DKHOME_DIR"
	%dk_call% dk_validate DKHTTP_DKHOME_DIR	"%dk_call% DKHOME_DIR"
	set "DIGITALKNOB_DIR=%DKHOME_DIR%/%DIGITALKNOB%"
    if NOT EXIST "%DIGITALKNOB_DIR%" (%dk_call% dk_mkdir "%DIGITALKNOB_DIR%")
	set "DKHTTP_DIGITALKNOB_DIR=%DKHTTP_DKHOME_DIR%/%DKHTTP_DIGITALKNOB%"

	%dk_call% dk_assertPath	DIGITALKNOB_DIR
	%dk_call% dk_assertVar	DKHTTP_DIGITALKNOB_DIR
%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0
 
	%dk_call% dk_echo
	%dk_call% dk_echo "Test Getting DIGITALKNOB_DIR . . ."
	%dk_call% dk_DIGITALKNOB_DIR
	%dk_call% dk_echo "DIGITALKNOB = %DIGITALKNOB%"
	%dk_call% dk_echo "DIGITALKNOB_DIR = %DIGITALKNOB_DIR%"
	%dk_call% dk_echo "DKHTTP_DIGITALKNOB = %DKHTTP_DIGITALKNOB%"
	%dk_call% dk_echo "DKHTTP_DIGITALKNOB_DIR = %DKHTTP_DIGITALKNOB_DIR%"
	
	%dk_call% dk_echo
	%dk_call% dk_echo "Test Setting DIGITALKNOB_DIR . . ."
	%dk_call% dk_DIGITALKNOB_DIR "C:/DigitalKnob"
	%dk_call% dk_echo "DIGITALKNOB = %DIGITALKNOB%"
	%dk_call% dk_echo "DIGITALKNOB_DIR = %DIGITALKNOB_DIR%"
	%dk_call% dk_echo "DKHTTP_DIGITALKNOB = %DKHTTP_DIGITALKNOB%"
	%dk_call% dk_echo "DKHTTP_DIGITALKNOB_DIR = %DKHTTP_DIGITALKNOB_DIR%"
%endfunction%
