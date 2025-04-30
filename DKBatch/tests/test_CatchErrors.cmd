@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::#################################################################################################################################################


:: https://reactos.org/archives/public/ros-diffs/2020-September/074204.html
:: https://stackoverflow.com/a/34987886/688352
:: https://stackoverflow.com/a/34987886

set "ErrCode[1073750988]=Unbalanced parentheses"
set "ErrCode[1073750989]=Missing operand"
set "ErrCode[1073750990]=Syntax error"
set "ErrCode[1073750991]=Invalid number"
set "ErrCode[1073750992]=Number larger than 32-bits"
set "ErrCode[1073750993]=Division by zero"

if "%~1" neq "" (call %~1)
%endfunction%

::############ set /a error codes ############
::1073750988 = Unbalanced parentheses
:testA
	echo: 
	echo Running testA . . .
	set /a "total=(2+1"
	
	echo ERROR:%errorlevel%: !ErrCode[%errorlevel%]!
%endfunction%

::1073750989 = Missing operand
:testB
	echo: 
	echo Running testB . . .
	set /a "total=5*"
	
	echo ERROR:%errorlevel%: !ErrCode[%errorlevel%]!
%endfunction%

::1073750990 = Syntax error
:testC
	echo: 
	echo Running testC . . .
	set /a "total=7$3"
	
	echo ERROR:%errorlevel%: !ErrCode[%errorlevel%]!
%endfunction%

::1073750991 = Invalid number
:testD
	echo: 
	echo Running testD . . .
	set /a "total=0xdeadbeeg"
	
	echo ERROR:%errorlevel%: !ErrCode[%errorlevel%]!
%endfunction%

::1073750992 = Number larger than 32-bits
:: largest number allowed is 2,147,483,647
:testE
	echo: 
	echo Running testE . . .
	set /a "num=2147483648"
	
	echo ERROR:%errorlevel%: !ErrCode[%errorlevel%]!
%endfunction%

::1073750993 = Division by zero.
:testF
	echo: 
	echo Running testF . . .
	set /a 1/0
	
	echo ERROR:%errorlevel%: !ErrCode[%errorlevel%]!
%endfunction%


:errorFunc
	%dk_call% dk_debug "test_CatchErrors"
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
