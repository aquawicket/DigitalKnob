@echo off&::###### DK.cmd #########################################################################################################################
if NOT exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if NOT defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


::####################################################################
::# dk_isNumber(<in> <ret:optional>)
::#
::#		Reference: https://stackoverflow.com/a/17584764
::#
:dk_isNumber
%setlocal%
	%dk_call% dk_debugFunc 1 2

	set "dk_isNumber_arg1=%~1"
	if defined %~1 (set "dk_isNumber_arg1=!%~1!")
	if NOT defined dk_isNumber_arg1 (goto:FALSE)
	set "dk_isNumber_arg1=%dk_isNumber_arg1:.=%"
	set "dk_isNumber_arg1=%dk_isNumber_arg1:+=%"

	if %dk_isNumber_arg1:-=% equ +%dk_isNumber_arg1:-=% (
		set "dk_isNumber=0"
	) else (
		:FALSE
		set "dk_isNumber=-1"
	)


	
::	::###### Return the array to the calling scope ######
::	 for /F "delims=" %%G in ('set dk_isNumber') do endlocal & (
::		if "!%~2!" equ "" if "%~2" neq "" (set "%~2=%dk_isNumber%")
::		set "%%G"
::	)
	
	endlocal & (
		set "dk_isNumber_arg1=%dk_isNumber_arg1%"
		set "dk_isNumber=%dk_isNumber%"
		if "%~2" neq "" (set "%~2=%dk_isNumber%")	
	)

	exit /b %dk_isNumber%
%endfunction%







::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	set "dkscope=dk_isNumber_DKTEST"
	%dk_call% dk_debugFunc 0
	
	%dk_call% dk_isNumber 69 rval		&& echo "!dk_isNumber_arg1! is a number, rval = !rval!" || echo "!dk_isNumber_arg1! is NOT a number"
	%dk_call% dk_isNumber 69			&& echo "!dk_isNumber_arg1! is a number" || echo "!dk_isNumber_arg1! is NOT a number"
	set "myNumber=42"
	%dk_call% dk_isNumber %myNumber%	&& echo "!dk_isNumber_arg1! is a number" || echo "!dk_isNumber_arg1! is NOT a number"
	%dk_call% dk_isNumber myNumber		&& echo "!dk_isNumber_arg1! is a number" || echo "!dk_isNumber_arg1! is NOT a number"
	%dk_call% dk_isNumber +0			&& echo "!dk_isNumber_arg1! is a number" || echo "!dk_isNumber_arg1! is NOT a number"
	%dk_call% dk_isNumber 0				&& echo "!dk_isNumber_arg1! is a number" || echo "!dk_isNumber_arg1! is NOT a number"
	%dk_call% dk_isNumber -0			&& echo "!dk_isNumber_arg1! is a number" || echo "!dk_isNumber_arg1! is NOT a number"
	%dk_call% dk_isNumber +1			&& echo "!dk_isNumber_arg1! is a number" || echo "!dk_isNumber_arg1! is NOT a number"
	%dk_call% dk_isNumber 1				&& echo "!dk_isNumber_arg1! is a number" || echo "!dk_isNumber_arg1! is NOT a number"
	%dk_call% dk_isNumber -1			&& echo "!dk_isNumber_arg1! is a number" || echo "!dk_isNumber_arg1! is NOT a number"
	%dk_call% dk_isNumber +1.23			&& echo "!dk_isNumber_arg1! is a number" || echo "!dk_isNumber_arg1! is NOT a number"
	%dk_call% dk_isNumber 1.23			&& echo "!dk_isNumber_arg1! is a number" || echo "!dk_isNumber_arg1! is NOT a number"
	%dk_call% dk_isNumber -1.23			&& echo "!dk_isNumber_arg1! is a number" || echo "!dk_isNumber_arg1! is NOT a number"
	%dk_call% dk_isNumber "+1.23"		&& echo "!dk_isNumber_arg1! is a number" || echo "!dk_isNumber_arg1! is NOT a number"
	%dk_call% dk_isNumber "1.23"		&& echo "!dk_isNumber_arg1! is a number" || echo "!dk_isNumber_arg1! is NOT a number"
	%dk_call% dk_isNumber "-1.23"		&& echo "!dk_isNumber_arg1! is a number" || echo "!dk_isNumber_arg1! is NOT a number"

	%dk_call% dk_isNumber "36a"			&& echo "!dk_isNumber_arg1! is a number" || echo "!dk_isNumber_arg1! is NOT a number"
	%dk_call% dk_isNumber word			&& echo "!dk_isNumber_arg1! is a number" || echo "!dk_isNumber_arg1! is NOT a number"
	%dk_call% dk_isNumber +word			&& echo "!dk_isNumber_arg1! is a number" || echo "!dk_isNumber_arg1! is NOT a number"
	%dk_call% dk_isNumber -word			&& echo "!dk_isNumber_arg1! is a number" || echo "!dk_isNumber_arg1! is NOT a number"
	%dk_call% dk_isNumber 123456789		&& echo "!dk_isNumber_arg1! is a number" || echo "!dk_isNumber_arg1! is NOT a number"
	%dk_call% dk_isNumber -123456789	&& echo "!dk_isNumber_arg1! is a number" || echo "!dk_isNumber_arg1! is NOT a number"
	%dk_call% dk_isNumber				&& echo "!dk_isNumber_arg1! is a number" || echo "!dk_isNumber_arg1! is NOT a number"
%endfunction%
