@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::################################################################################
::# dk_deprecated(message)
::#
::#    Print a deprecated message to the console
::#
::#    @message - The message to print
::#
:dk_deprecated
setlocal
	%dk_call% dk_debugFunc 1
	
    %dk_call% dk_log DEPRECATED "%~1"
%endfunction%




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0

    %dk_call% dk_deprecated "test dk_deprecated message"
%endfunction%
