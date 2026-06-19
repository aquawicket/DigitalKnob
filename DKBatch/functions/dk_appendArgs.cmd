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


rem ####################################################################
rem # dk_appendArgs(variable, string)
rem #
rem #
:dk_appendArgs
%setlocal%

	rem ###### input ######
	%dk_call% dk_allButFirstArgs %*


	if defined %~1 (
		set "dk_appendArgs=!%~1! %dk_allButFirstArgs%"
	) else (
		set "dk_appendArgs=%dk_allButFirstArgs%"
	)
	
	
	:return
	endlocal & (
		set "dk_appendArgs=%dk_appendArgs%"
		if "%~1" neq "" (
			set "%~1=%dk_appendArgs%"
		) else (
			echo %dk_appendArgs%
		)
	)
%endfunction%











rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

	%dk_call% dk_appendArgs myVar 123 abc
	%dk_call% dk_debug "myVar = %myVar%"

	%dk_call% dk_appendArgs myVar 456 def
	%dk_call% dk_debug "myVar = %myVar%"

	%dk_call% dk_appendArgs myVar 789 ghi
	%dk_call% dk_debug "myVar = %myVar%"
%endfunction%
