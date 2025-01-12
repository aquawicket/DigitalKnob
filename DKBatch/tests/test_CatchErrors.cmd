::@echo off
if not defined DKBATCH_FUNCTIONS_DIR_ set "DKBATCH_FUNCTIONS_DIR_=..\functions\"
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

echo testCatchErrors[%~1]
if not "%~1"=="" call %~1
!test_endfunction!
ECHO ############# :main SHOULD NOT GET HERE #######################
!endfunction!



:errorFunc
setlocal enableDelayedExpansion

	%dk_call% dk_debug "test_CatchErrors"

	A SYNTAX ERROR

	echo "after error"
	
!test_endfunction!
ECHO ############# :errorFunc SHOULD NOT GET HERE #######################
!endfunction!


:noErrorFunc
setlocal enableDelayedExpansion

	%dk_call% dk_debug "noError"

!test_endfunction!
ECHO ############# :noErrorFunc SHOULD NOT GET HERE #######################
!endfunction!

::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal enableDelayedExpansion
    %dk_call% dk_debugFunc 0
	
	%dk_call% test_CatchErrors :errorFunc

	%dk_call% test_CatchErrors :noErrorFunc

!test_endfunction!
ECHO ############# :DKTEST SHOULD NOT GET HERE #######################
!endfunction!