@echo off&::###### DK.cmd #########################################################################################################################
if NOT defined DKBATCH_FUNCTIONS_DIR_ (set DKBATCH_FUNCTIONS_DIR_=%USERPROFILE%/DigitalKnob/Development/DKBatch/functions/)
if NOT EXIST "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if NOT defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


::################################################################################
::# dk_testReturn(input, output)
::#
::#
:dk_testReturn
%setlocal%
	%dk_call% dk_debugFunc 1 2

	set "input=%~1"
	set "dk_testReturn=%input:input=output%"

	endlocal & (
		set "dk_testReturn=%dk_testReturn%"
		if "%~2" neq "" (
			set "%~2=%dk_testReturn%"
		) else (
			echo %dk_testReturn%
		)
	)
%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0

	::### Result as global variable							[GLOBAL]
	%dk_call% dk_echo
	%dk_call% dk_testReturn "inputA"
	%dk_call% dk_echo "dk_testReturn = %dk_testReturn%"
	
	::### Result as parameter variable						[GLOBAL][PARAM]
	%dk_call% dk_echo
	%dk_call% dk_testReturn "inputB" resultB
	%dk_call% dk_echo "resultB = %resultB%"
	%dk_call% dk_echo "dk_testReturn = %dk_testReturn%"
	
	::### Result as return value							[GLOBAL][-R̶E̶T̶U̶R̶N̶ ]
	::%dk_call% dk_echo
	::%dk_call% resultC=dk_testReturn "inputC"				&::NOTE: batch doesn't support return values
	::%dk_call% dk_echo "resultC = %resultC%"
	::%dk_call% dk_echo "dk_testReturn = %dk_testReturn%"
	
	::### Result as return value and parameter variable 	[GLOBAL][PARAM][-R̶E̶T̶U̶R̶N̶ ]
	::%dk_call% dk_echo
	::%dk_call% resultD=dk_testReturn "inputDE"				&::NOTE: batch doesn't support return values
	::%dk_call% dk_echo "resultD = %resultD%"
	::%dk_call% dk_echo "resultE = %resultE%"
	::%dk_call% dk_echo "dk_testReturn = %dk_testReturn%"
	
	::### Result from stdout								[STDOUT]
	%dk_call% dk_echo
	for /f "usebackq tokens=*" %%G in (`call dk_testReturn.cmd "inputC"`) do (set "resultC=%%G")
	%dk_call% dk_echo "resultC = %resultC%"
	::%dk_call% dk_echo "dk_testReturn = %dk_testReturn%"	&::NOTE: endlocal cannot be seen outside of command substituion			

%endfunction%
