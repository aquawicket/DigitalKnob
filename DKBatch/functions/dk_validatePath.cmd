@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

if exist "!%~1!" (%return%)
::################################################################################
::# dk_validate(variable, code) NO_HALT
::#
::#    Check if a variable is valid, otherwise run code to validate the variable
::#
:dk_validatePath
    call dk_debugFunc 2
:: setlocal

    ::%dk_call% dk_stringContains "%~2" "call" || %dk_call% dk_error "dk_validate parameter 2 requires the use of call"
    %~2
    
	if "%~3" equ "NO_HALT" %return%
    if not defined %~1    %dk_call% dk_error "dk_validatePath was unable to set the path variable:%~1 with the code provided"
    
	
	if not exist "!%~1!"    %dk_call% dk_error "dk_validatePath was unable to locate the path:%~1 with the code provided"

%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
    call dk_debugFunc 0
 setlocal
 
    %dk_call% dk_validatePath DIGITALKNOB_DIR "%dk_call% dk_DIGITALKNOB_DIR"
    %dk_call% dk_echo "DIGITALKNOB_DIR = %DIGITALKNOB_DIR%"
	
	%dk_call% dk_validatePath DKTOOLS_DIR "%dk_call% dk_DKTOOLS_DIR"
    %dk_call% dk_echo "DKTOOLS_DIR = %DKTOOLS_DIR%"
	
	%dk_call% dk_validatePath DKDOWNLOAD_DIR "%dk_call% dk_DKDOWNLOAD_DIR"
    %dk_call% dk_echo "DKDOWNLOAD_DIR = %DKDOWNLOAD_DIR%"
	
::	%dk_call% dk_validatePath NONEXISTENT_DIR "%dk_call% dk_DKDOWNLOAD_DIR"
::  %dk_call% dk_echo "NONEXISTENT_DIR = %NONEXISTENT_DIR%"
%endfunction%