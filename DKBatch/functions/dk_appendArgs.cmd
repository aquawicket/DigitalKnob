@echo off&::###### DK.cmd #########################################################################################################################
if NOT EXIST "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if NOT defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


::####################################################################
::# dk_appendArgs(variable, string)
::#
::#
:dk_appendArgs
%setlocal%
	%dk_call% dk_debugFunc 2 99

	::###### input ######
	%dk_call% dk_allButFirstArgs %*


	if defined %~1 (
		set "dk_appendArgs=!%~1! %dk_allButFirstArgs%"
	) else (
		set "dk_appendArgs=%dk_allButFirstArgs%"
	)
	
	
	::###### output ######
	endlocal & (
		set "dk_appendArgs=%dk_appendArgs%"
		if "%~1" neq "" (
			set "%~1=%dk_appendArgs%"
		) else (
			echo %dk_appendArgs%
		)
	)
%endfunction%











::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0

	%dk_call% dk_appendArgs myVar 123 abc
	%dk_call% dk_echo "myVar = %myVar%"

	%dk_call% dk_appendArgs myVar 456 def
	%dk_call% dk_echo "myVar = %myVar%"

	%dk_call% dk_appendArgs myVar 789 ghi
	%dk_call% dk_echo "myVar = %myVar%"
%endfunction%
