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


rem #################################################################################
rem # dk_getParameterValue(NAME)
rem #
:dk_getParameterValue
%setlocal%

    :getParameter_loop
	if /i "%~1" equ "%~2" (
		if "%~3" equ "" (set "_value_=1")
		if "%~3" neq "" (set "_value_=%~3")
		goto end_getParameter_loop
	)
	if "%~3" neq "" (
		shift /2
		goto getParameter_loop
	)
	:end_getParameter_loop

    endlocal & (
		set "%~1=%_value_%"
	)
%endfunction%





rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

	call :TEST_getParameter ARG1 "arg1 data" ARG3 ARG4 "arg4 data" ARG5 "arg5 data" ARG6 "arg6"

%endfunction%


:TEST_getParameter ARG1 ARG2 ARG3 ARG4 ARG5 ARG6 ARG7 ARG8 ARG9 ...
%setlocal%

	%dk_call% dk_getParameterValue ARG1 %*
	%dk_call% dk_getParameterValue ARG2 %*
	%dk_call% dk_getParameterValue ARG3 %*
	%dk_call% dk_getParameterValue ARG4 %*
	%dk_call% dk_getParameterValue ARG5 %*
	%dk_call% dk_getParameterValue ARG6 %*

	%dk_call% dk_echo "ARG1 = %ARG1%"
	%dk_call% dk_echo "ARG2 = %ARG2%"
	%dk_call% dk_echo "ARG3 = %ARG3%"
	%dk_call% dk_echo "ARG4 = %ARG4%"
	%dk_call% dk_echo "ARG5 = %ARG5%"
	%dk_call% dk_echo "ARG6 = %ARG6%"
	
%endfunction%