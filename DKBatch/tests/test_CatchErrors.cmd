::@echo off
if not defined DKBATCH_FUNCTIONS_DIR_ set "DKBATCH_FUNCTIONS_DIR_=..\functions\"
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

echo testCatchErrors[%~1]
if not "%~1"=="" call %~1
%endfunction%




:errorFunc
setlocal enableDelayedExpansion

	%dk_call% dk_debug "test_CatchErrors"

	A SYNTAX ERROR

	echo "after error"
	
%endfunction%



:noErrorFunc
setlocal enableDelayedExpansion

	%dk_call% dk_debug "noError"

%endfunction%


::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal enableDelayedExpansion
    %dk_call% dk_debugFunc 0
	
	%dk_call% test_CatchErrors :errorFunc

	%dk_call% test_CatchErrors :noErrorFunc

%endfunction%
