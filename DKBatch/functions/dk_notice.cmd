@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %0

::call dk_source dk_log
::################################################################################
::# dk_notice(message)
::#
::#    Print a notice message to the console
::#
::#    @message - The message to print
::#
:dk_notice
 setlocal
    call dk_debugFunc 1
    
    %dk_call% dk_log NOTICE "%~1"
%endfunction%




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
 setlocal
    call dk_debugFunc 0
    
    %dk_call% dk_notice "test dk_notice message"
%endfunction%
