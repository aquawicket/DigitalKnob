@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*

::################################################################################
::# dk_fixme(message)
::#
::#    Print a fixme message to the console
::#
::#    @message - The message to print
::#
:dk_fixme
 setlocal
    call dk_debugFunc 1
    
    %dk_call% dk_log FIXME "%~1"
%endfunction%




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
 setlocal
    call dk_debugFunc 0
    
    %dk_call% dk_fixme "test dk_fixme message"
%endfunction%
