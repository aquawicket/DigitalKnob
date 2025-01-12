@echo off
if not defined DKBATCH_FUNCTIONS_DIR_ set "DKBATCH_FUNCTIONS_DIR_=..\functions\"
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*
if not "%~1"=="" call %~1
%endfunction%


:: https://stackoverflow.com/a/34987886/688352

::############ set /a error codes ############
::1073750988 = Unbalanced parentheses
:testA
	set /a "up=1+8-(2*5"
%endfunction%

::1073750989 = Missing operand
:testB
	:: TODO
%endfunction%

::1073750990 = Syntax error
:testC
	:: TODO
%endfunction%

::1073750991 = Invalid number
:testD
	:: TODO
%endfunction%

::1073750992 = Number larger than 32-bits
:testE
	:: TODO
%endfunction%

::1073750993 = Division by zero.
:testF
	set /a 1/0
%endfunction%


:errorFunc
	%dk_call% dk_debug "test_CatchErrors"
	A SYNTAX ERROR
	echo "after error"
%endfunction%

:noErrorFunc
	%dk_call% dk_debug "noError"
%endfunction%


::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal enableDelayedExpansion
    %dk_call% dk_debugFunc 0
	
	%dk_call% test_CatchErrors :testA
	%dk_call% test_CatchErrors :testB
	%dk_call% test_CatchErrors :testC
	%dk_call% test_CatchErrors :testD
	%dk_call% test_CatchErrors :testE
	%dk_call% test_CatchErrors :testF
	


%endfunction%
