@echo off&::###### DK.cmd #########################################################################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


::################################################################################
::# dk_testReturn(input, output)
::#
::#
:dk_testReturn
%setlocal%
	%dk_call% dk_debugFunc 1 2

	set "input=%~1"
	set "output=%input:input=output%"

	endlocal & (
		set "dk_testReturn=%output%"
		if "%~2" neq "" (
			set "%~2=%output%"
		) else (
			echo %output%
		)
	)

::%endfunction%
exit /b -1





::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0

	::### Result as global variable
	%dk_call% dk_echo
	%dk_call% dk_testReturn "inputA"
	%dk_call% dk_echo "dk_testReturn = %dk_testReturn%"
	
	::### Result as parameter
	%dk_call% dk_echo
	%dk_call% dk_testReturn "inputB" resultB
	%dk_call% dk_echo "resultB = %resultB%"
	%dk_call% dk_echo "dk_testReturn = %dk_testReturn%"
	
	::NOTE: ###### WORK IN PROGRESS ######
	::### Result as return value
	%dk_call% dk_echo
	::resultC=$(dk_call dk_testReturn "inputC");
	for /f "usebackq tokens=*" %%G in (`call dk_testReturn "inputC"`) do (
		echo %%G
		set "resultC=%%G"
	)
	%dk_call% dk_echo "resultC = %resultC%"
	::%dk_call% dk_echo "dk_testReturn = %dk_testReturn%"	  &::NOTE: endlocal cannot be seen outside of command substituion			

%endfunction%
exit /b -1
