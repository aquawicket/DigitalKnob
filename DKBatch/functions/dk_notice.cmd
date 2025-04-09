@echo off
if not defined DK_CMD (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)

::%dk_call% dk_source dk_log
::################################################################################
::# dk_notice(message)
::#
::#    Print a notice message to the console
::#
::#    @message - The message to print
::#
:dk_notice
setlocal
    %dk_call% dk_debugFunc 1
    
    %dk_call% dk_log NOTICE "%~1"
%endfunction%




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0
   
    %dk_call% dk_notice "test dk_notice message"
%endfunction%
