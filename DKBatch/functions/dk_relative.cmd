@rem shebang
@echo off&rem ###### DK.cmd #########################################################################################################################
if not defined DKINIT_cmd (
	setlocal enableDelayedExpansion
	if NOT EXIST "%DK.cmd%" (set "DK.cmd=%USERPROFILE%\Digital Knob\Development\DKBatch\functions\DK.cmd")
	if NOT DEFINED DK.cmd (for /F "delims=" %%G IN ('dir /b/s/a:-d "%USERPROFILE%\DK.cmd"') do (set "DK.cmd=%%~fG"))
	if NOT EXIST "!DK.cmd!" (
		start "" /b /wait /min "curl.exe" --silent --location --create-dirs --output "!DK.cmd!" http://aquawicket.com/DigitalKnob/Development/DKBatch/functions/DK.cmd)
	call "!DK.cmd:/=\!" "%%~0" %%*
	exit /b %errorlevel%
)
rem #################################################################################################################################################


rem ################################################################################
rem # dk_relative(<absolute_path>, <base_directory>, <rtn_var>:OPTIONAL)
rem #
rem #		TODO:   reference the link below
rem #    https://www.stevebreese.com/Relative-Path-Calculator
rem #
:dk_relative
%setlocal%
	
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





rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

	%dk_call% dk_echo
	%dk_call% dk_set from_path "%USERPROFILE:\=/%/Digital Knob/Development/DKBatch/functions"
	%dk_call% dk_set to_path "%USERPROFILE:\=/%/Digital Knob"
	%dk_call% dk_relative "%to_path%" "%from_path%"
	%dk_call% dk_printVar dk_relative
	%dk_call% dk_chdir %from_path%
	%dk_call% dk_echo "CD = %CD:\=/%"
	%dk_call% dk_chdir %dk_relative%
	%dk_call% dk_echo "CD = %CD:\=/%"
	
	%dk_call% dk_echo
	%dk_call% dk_set from_path "%USERPROFILE:\=/%/Digital Knob"
	%dk_call% dk_set to_path "%USERPROFILE:\=/%/Digital Knob/Development/DKBatch"
	%dk_call% dk_relative "%to_path%" "%from_path%"
	%dk_call% dk_printVar dk_relative
	%dk_call% dk_chdir %from_path%
	%dk_call% dk_echo "CD = %CD:\=/%"
	%dk_call% dk_chdir %dk_relative%
	%dk_call% dk_echo "CD = %CD:\=/%"
%endfunction%
