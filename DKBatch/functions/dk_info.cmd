@echo off
if not defined DK_CMD (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*)

::################################################################################
::# dk_info(message)
::#
::#    Print a info message to the console
::#
::#    @message - The message to print
::#
:dk_info
setlocal
	%dk_call% dk_debugFunc 1
    %dk_call% dk_log INFO "%~1"
%endfunction%




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0

    %dk_call% dk_info "test string from dk_info"
%endfunction%
