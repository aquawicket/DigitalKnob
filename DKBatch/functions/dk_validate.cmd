@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %0

::################################################################################
::# dk_validate(variable, code)
::#
::#    Check if a variable is valid, otherwise run code to validate the variable
::#
:dk_validate
:: setlocal
    call dk_debugFunc 2

    if defined %~1 if "%~1" neq "" (goto:eof)     &:: if the variable is already valid, return
    
    %dk_call% dk_stringContains "%~2" "call" || %dk_call% dk_error "dk_validate parameter 2 requires the use of call"
    ::call %~2
    %~2
    
    if not defined %~1 dk_error "dk_validate was unable to set the variable:%~1 with the code provided"
    if "%~1"=="" dk_error "dk_validate called the code requested, but the variable is still invalid"
    
    %dk_call% dk_debug "dk_validate: %~1"
    %dk_call% dk_printVar "%~1"
%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
 setlocal
    call dk_debugFunc 0
    
    %dk_call% dk_validate DIGITALKNOB_DIR "%dk_call% dk_getDKPaths"
    %dk_call% dk_echo "DIGITALKNOB_DIR = %DIGITALKNOB_DIR%"
    %dk_call% dk_echo "DKTOOLS_DIR = %DKTOOLS_DIR%"
    %dk_call% dk_echo "DKDOWNLOAD_DIR = %DKDOWNLOAD_DIR%"
%endfunction%
