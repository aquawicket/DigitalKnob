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
	)
%endfunction%





::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0

	::### Result as global variable
	%dk_call% dk_echo
	%dk_call% dk_testReturn "inputA"
	%dk_call% dk_echo "dk_testReturn = %dk_testReturn%"

%endfunction%
