@echo off
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)

::################################################################################
::# dk_fixme(message)
::#
::#    Print a fixme message to the console
::#
::#    @message - The message to print
::#
:dk_fixme
setlocal
	%dk_call% dk_debugFunc 1
	
    %dk_call% dk_log FIXME "%~1"
%endfunction%




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0

    %dk_call% dk_fixme "test dk_fixme message"
%endfunction%
