@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::################################################################################
::# dk_info(message)
::#
::#    Print a info message to the console
::#
::#    @message - The message to print
::#
:dk_info
    call dk_debugFunc 1
 setlocal
 
    %dk_call% dk_log INFO "%~1"
%endfunction%




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
    call dk_debugFunc 0
 setlocal
 
    %dk_call% dk_info "test string from dk_info"
%endfunction%
