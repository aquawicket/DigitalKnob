@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::##################################################################################
::# dk_todo(message)
::#
::#    Print a todo message to the console
::#
::#    @message - The message to print
::#
:dk_todo
    call dk_debugFunc 0 1
 setlocal
 
    %dk_call% dk_log TODO "%~1"
%endfunction%




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
    call dk_debugFunc 0
 setlocal   
    %dk_call% dk_todo "test dk_todo message"
%endfunction%
