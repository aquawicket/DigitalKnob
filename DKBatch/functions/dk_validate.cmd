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
rem # dk_validate(variable, code) NO_HALT
rem #
rem #    Check if a variable is valid, otherwise run code to validate the variable
rem #
:dk_validate
	if DEFINED %~1 (%return%)
%setlocal%
	
rem	set "var=%~1"

rem	########### Print function recursion count #############################
rem	if defined %~n0_count (set /a %~n0_count+=1) else (set /a %~n0_count=0)
rem	echo %~n0_count:!%~n0_count! %~1
rem	########################################################################
	
rem	######### Recursion infinate loop detection (1st arg) ##################
rem if defined func_args (
rem		if "!func_args!" neq "!func_args:%~1=!" (
rem			echo "!func_args!"
rem			echo "!func_args:%~1=!"
rem			echo %red% Detected infinate recursion loop %clr%
rem			echo %red% 'func_args %~1' called with the same args within itself
rem			echo.
rem		)
rem	)
rem	(set func_args=!func_args!%~1)
rem	########################################################################

	rem ### execute code ###
	For /F "tokens=1*" %%A in ("%*") DO (
		set ARGN=%%B
		set -ARGN=%%~B
	)
	
	rem echo %~2
	rem echo 	%-ARGN%
	%-ARGN%
	

	rem if /i "%~3" equ "NO_HALT"	(%return%)
	if NOT DEFINED %~1	(%dk_call% dk_error "dk_validate was unable to set the variable:'%~1' with the code provided:'%-ARGN%'")
	
	set "value=!%~1!"
	endlocal & (
		set "%~1=%value%"
	)
	
	%dk_call% dk_debug "%~1 = '!%~1!'"
%endfunction%






rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

	%dk_call% dk_validate DIGITALKNOB_DIR %dk_call% dk_DIGITALKNOB_DIR
	%dk_call% dk_debug "DIGITALKNOB_DIR = '%DIGITALKNOB_DIR%'"

	%dk_call% dk_validate DKTOOLS_DIR %dk_call% dk_DKTOOLS_DIR
	%dk_call% dk_debug "DKTOOLS_DIR = '%DKTOOLS_DIR%'"

	%dk_call% dk_validate DKDOWNLOAD_DIR %dk_call% dk_DKDOWNLOAD_DIR
	%dk_call% dk_debug "DKDOWNLOAD_DIR = '%DKDOWNLOAD_DIR%'"

	rem %dk_call% dk_validate TESTABC %dk_call% dk_testB
%endfunction%
