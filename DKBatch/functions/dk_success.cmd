@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::call dk_source dk_log
::################################################################################
::# dk_success(message)
::#
::#    Print a warning message to the console
::#
::#    @message - The message to print
::#
:dk_success
    call dk_debugFunc 1
 setlocal
 
    %dk_call% dk_log SUCCESS "%~1"
%endfunction%




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
    call dk_debugFunc 0
 setlocal
 
    %dk_call% dk_success "test dk_success message"
%endfunction%
