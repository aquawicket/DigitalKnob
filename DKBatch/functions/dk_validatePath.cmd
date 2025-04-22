@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%A IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpA")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::#################################################################################################################################################


::################################################################################
::# dk_validate(variable, code) NO_HALT
::#
::#    Check if a variable is valid, otherwise run code to validate the variable
::#
:dk_validatePath
::setlocal enableDelayedExpansion
    %dk_call% dk_debugFunc 2

    if exist "!%~1!" (%return%)
	
    %~2
    
	if "%~3" equ "NO_HALT" (%return%)
    if not defined %~1		%dk_call% dk_error "dk_validatePath was unable to set the path variable:%~1 with the code provided"
	if not exist "!%~1!"    %dk_call% dk_error "dk_validatePath was unable to locate the path:%~1 with the code provided"
%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0

    %dk_call% dk_validatePath DIGITALKNOB_DIR "%dk_call% dk_DIGITALKNOB_DIR"
    %dk_call% dk_echo "DIGITALKNOB_DIR = %DIGITALKNOB_DIR%"
	
	%dk_call% dk_validatePath DKTOOLS_DIR "%dk_call% dk_DKTOOLS_DIR"
    %dk_call% dk_echo "DKTOOLS_DIR = %DKTOOLS_DIR%"
	
	%dk_call% dk_validatePath DKDOWNLOAD_DIR "%dk_call% dk_DKDOWNLOAD_DIR"
    %dk_call% dk_echo "DKDOWNLOAD_DIR = %DKDOWNLOAD_DIR%"
	
::	%dk_call% dk_validatePath NONEXISTENT_DIR "%dk_call% dk_DKDOWNLOAD_DIR"
::  %dk_call% dk_echo "NONEXISTENT_DIR = %NONEXISTENT_DIR%"
%endfunction%
