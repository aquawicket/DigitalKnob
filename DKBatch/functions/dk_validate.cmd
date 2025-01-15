@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

if defined %~1 (%return%)
::################################################################################
::# dk_validate(variable, code) NO_HALT
::#
::#    Check if a variable is valid, otherwise run code to validate the variable
::#
:dk_validate
::setlocal
    %dk_call% dk_debugFunc 2

    ::%dk_call% dk_stringContains "%~2" "dk_call" || %dk_call% dk_error "dk_validate parameter 2 requires the use of dk_call"
    ::echo %~2
	%~2
    
	if "%~3" equ "NO_HALT" %endfunction%
    if not defined %~1    %dk_call% dk_error "dk_validate was unable to set the variable:%~1 with the code provided"
%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
    %dk_call% dk_debugFunc 0

 
    %dk_call% dk_validate DIGITALKNOB_DIR "%dk_call% dk_DIGITALKNOB_DIR"
    %dk_call% dk_echo "DIGITALKNOB_DIR = %DIGITALKNOB_DIR%"
	
	%dk_call% dk_validate DKTOOLS_DIR "%dk_call% dk_DKTOOLS_DIR"
    %dk_call% dk_echo "DKTOOLS_DIR = %DKTOOLS_DIR%"
	
	%dk_call% dk_validate DKDOWNLOAD_DIR "%dk_call% dk_DKDOWNLOAD_DIR"
    %dk_call% dk_echo "DKDOWNLOAD_DIR = %DKDOWNLOAD_DIR%"
	
	
	%dk_call% dk_validate TESTABC "%dk_call% dk_testB"
	
%endfunction%
