@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %0

::################################################################################
::# dk_fatal(message)
::#
::#    Print a error message to the console
::#
::#    @message - The message to print
::#
:dk_fatal
 setlocal
    ::call dk_debugFunc 1
    
    %dk_call% dk_log FATAL "%~1"
%endfunction%




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
 setlocal
    call dk_debugFunc 0
    
    %dk_call% dk_fatal "test dk_fatal message"
%endfunction%
