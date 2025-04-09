@echo off
if not defined DK_CMD (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)

::################################################################################
::# dk_warning(message)
::#
::#    Print a warning message to the console
::#
::#    @message - The message to print
::#
:dk_warning
setlocal
	%dk_call% dk_debugFunc 1
	
    %dk_call% dk_log WARNING "%~1"
%endfunction%




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0

    %dk_call% dk_warning "test dk_warning message"
%endfunction%
