echo dk_test.cmd %*
@echo off
if not defined DK.cmd call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~f0 %*

::####################################################################
::# dk_testError()
::#
:dk_testError
setlocal enableDelayedExpansion
    %dk_call% dk_debugFunc 0

	SYNTAX ERROR
%endfunction%








::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal enableDelayedExpansion
    %dk_call% dk_debugFunc 0

    %dk_call% dk_testError
%endfunction%
