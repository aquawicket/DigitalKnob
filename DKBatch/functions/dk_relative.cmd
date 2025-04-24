@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::#################################################################################################################################################


::################################################################################
::# dk_relative(<absolute_path>, <base_directory>, <rtn_var>:OPTIONAL)
::#
::#		TODO:   reference the link below
::#    https://www.stevebreese.com/Relative-Path-Calculator
::#
:dk_relative
setlocal
	%dk_call% dk_debugFunc 1 3
	
	set "src=%~1"
	if defined %1 (set "src=!%~1!")
	set "bas=%~2"
	if not defined bas (set "bas=%cd%")
	
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
setlocal
	%dk_call% dk_debugFunc 0

	echo:
	
	%dk_call% dk_set from_path "%USERPROFILE:\=/%/digitalknob/Development/DKBatch/functions"
	%dk_call% dk_set to_path "%USERPROFILE:\=/%/digitalknob"
	%dk_call% dk_relative "%to_path%" "%from_path%"
	%dk_call% dk_printVar dk_relative
	cd %from_path%
	echo CD = %CD:\=/%
	cd %dk_relative%
	echo CD = %CD:\=/%
	
	echo:
	%dk_call% dk_set from_path "%USERPROFILE:\=/%/digitalknob"
	%dk_call% dk_set to_path "%USERPROFILE:\=/%/digitalknob/Development/DKBatch"
	%dk_call% dk_relative "%to_path%" "%from_path%"
	%dk_call% dk_printVar dk_relative
	cd %from_path%
	echo CD = %CD:\=/%
	cd %dk_relative%
	echo CD = %CD:\=/%
%endfunction%
