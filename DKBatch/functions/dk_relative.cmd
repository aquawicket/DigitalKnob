@echo off&::###### DK.cmd #########################################################################################################################
if NOT EXIST "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if NOT defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


::################################################################################
::# dk_relative(<absolute_path>, <base_directory>, <rtn_var>:OPTIONAL)
::#
::#		TODO:   reference the link below
::#    https://www.stevebreese.com/Relative-Path-Calculator
::#
:dk_relative
%setlocal%
	%dk_call% dk_debugFunc 1 3
	
	set "src=%~1"
	if defined %1 (set "src=!%~1!")
	set "bas=%~2"
	if NOT defined bas (set "bas=%CD%")
	
	for /f "tokens=*" %%a in ("%src%") do (set "src=%%~fa")
	for /f "tokens=*" %%a in ("%bas%") do (set "bas=%%~fa")
	set "mat="	&rem variable to store matching part of the name
	set "upp="	&rem variable to reference a parent
	for /f "tokens=*" %%a in ('echo.%bas:\=^&echo.%') do (
		set "sub=!sub!%%a\"
		call set "tmp=%%src:!sub!=%%"
		if "!tmp!" neq "!src!" (
			set "mat=!sub!"
		)else (
			set "upp=!upp!../"
		)
	)
	set "dk_relative=%upp%!src:%mat%=!"
	
	endlocal & (
		set "dk_relative=%dk_relative:\=/%"
		if "%~3" neq "" (set %~3=%dk_relative:\=/%)
	)
%endfunction%





::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0

	%dk_call% dk_echo
	%dk_call% dk_set from_path "%USERPROFILE:\=/%/DigitalKnob/Development/DKBatch/functions"
	%dk_call% dk_set to_path "%USERPROFILE:\=/%/DigitalKnob"
	%dk_call% dk_relative "%to_path%" "%from_path%"
	%dk_call% dk_printVar dk_relative
	%dk_call% dk_chdir %from_path%
	%dk_call% dk_echo "CD = %CD:\=/%"
	%dk_call% dk_chdir %dk_relative%
	%dk_call% dk_echo "CD = %CD:\=/%"
	
	%dk_call% dk_echo
	%dk_call% dk_set from_path "%USERPROFILE:\=/%/DigitalKnob"
	%dk_call% dk_set to_path "%USERPROFILE:\=/%/DigitalKnob/Development/DKBatch"
	%dk_call% dk_relative "%to_path%" "%from_path%"
	%dk_call% dk_printVar dk_relative
	%dk_call% dk_chdir %from_path%
	%dk_call% dk_echo "CD = %CD:\=/%"
	%dk_call% dk_chdir %dk_relative%
	%dk_call% dk_echo "CD = %CD:\=/%"
%endfunction%
