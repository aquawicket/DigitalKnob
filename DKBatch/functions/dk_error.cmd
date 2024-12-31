@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::################################################################################
::# dk_error(message)
::#
::#    Print a error message to the console
::#
::#    @message - The message to print
::#
:dk_error
    ::%dk_call% dk_debugFunc 1
 setlocal
 
    %dk_call% dk_log ERROR "%~1"
%endfunction%




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
    %dk_call% dk_debugFunc 0
 setlocal
 
    %dk_call% dk_error "test dk_error message"
%endfunction%
