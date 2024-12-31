@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::################################################################################
::# dk_verbose(message)
::#
::#    Print a verbose message to the console
::#
::#    @message - The message to print
::#
:dk_verbose
    %dk_call% dk_debugFunc 1
 setlocal
 
    %dk_call% dk_log VERBOSE "%~1"
%endfunction%




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
    %dk_call% dk_debugFunc 0
 setlocal
 
    %dk_call% dk_verbose "test dk_verbose message"
%endfunction%
