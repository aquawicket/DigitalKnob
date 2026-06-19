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

rem echo.
rem if "%~1" neq "" (echo 1 = %~1)
rem if "!errorlevel!" neq "" (echo errorlevel = !errorlevel!)
rem if "!LAST_STATUS!" neq "" (echo LAST_STATUS = !LAST_STATUS!)


rem if NOT defined dk_return_PRINT_SUCCESS (set "dk_return_PRINT_SUCCESS=1")
if NOT defined dk_return_PRINT_ERRORS (set "dk_return_PRINT_ERRORS=1")
rem if NOT defined dk_return (set "dk_return=%dk_call% dk_return")

rem ################################################################################
rem dk_return(exit_code, message)
rem #
rem #		dk_return						pass
rem #		dk_return  0					pass
rem #		dk_return "message"				pass
rem #		dk_return  0 "message"			pass
rem #		dk_return -1					error
rem #		dk_return  1					error
rem #		dk_return -1 "error message"	error
rem #		dk_return  1 "error message"	error
rem #
:dk_return
%setlocal%

	set "arg1=%~1"
	set "arg2=%~2"
	if defined %~1 (set "arg1=!%~1!")
	
	if NOT defined arg1 (goto :endNumCheck)
	set "arg1=%arg1:.=%"
	set "arg1=%arg1:+=%"
	if %arg1:-=% equ +%arg1:-=% (set "arg1IsNumber=1")
	:endNumCheck

	rem ##### No Parameters ######
	if NOT defined arg1 (

		rem echo ##### No Parameters ######
		set "LAST_STATUS=!errorlevel!"
		set "LAST_MESSAGE="
	
	rem ##### 1 Parameter ######
	) else if NOT defined arg2 (

		rem echo ##### 1 Parameter ######
		if defined arg1IsNumber (
			set "LAST_STATUS=%~1"
			set "LAST_MESSAGE="
		) else (
			set "LAST_STATUS=!errorlevel!"
			set "LAST_MESSAGE=%~1"
		)

	rem ##### 2 Parameters ######
	) else if defined arg2 (

		rem echo ##### 2 Parameters ######
		set "LAST_STATUS=%~1"
		set "LAST_MESSAGE="
	)

	set "dk_return_PRINT=!dk_return_PRINT!"
	set "LAST_FILE=!__FILENAME__!"
	set "LAST_FUNC=!__FUNC__!"
	set "LAST_ARGS=!__ARGV__!"
	
	if "%dk_return_PRINT_SUCCESS%" equ "1" (
		if "!LAST_STATUS!" equ "0"	(echo "!LAST_FUNC!(!LAST_ARGV!):%green%!LAST_STATUS! '!LAST_MESSAGE!' %clr%")
	) 
	if "%dk_return_PRINT_ERRORS%" equ "1" (
		if "!LAST_STATUS!" neq "0"	(
			echo "!LAST_FUNC!(!LAST_ARGV!):%red%!LAST_STATUS! '!LAST_MESSAGE!' %clr%"
			%dk_call% dk_stacktrace
		)
	)
	
rem exit /b !LAST_STATUS! & set "LAST_STATUS="
exit /b 0