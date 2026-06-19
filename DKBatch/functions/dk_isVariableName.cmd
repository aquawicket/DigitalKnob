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
rem # dk_isVariableName(string rtn_var)
rem #
rem #  https://stackoverflow.com/a/17584764
rem #
rem #
rem #
rem #
:dk_isVariableName
setlocal disableDelayedExpansion

  set name=%~1
  set %~1=PASSED
  call set value=%%%~1%%

rem  echo.
rem  echo name = %name%
rem  echo value = %value%

  if "%value%" equ "PASSED" (set "dk_isVariableName=0") else (set "dk_isVariableName=1")

  
rem  for /f "delims=$-_0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ" %%A in ("%~1") do (set "bad_characters=%%A")
rem
rem  if defined bad_characters (
rem		set "dk_isVariableName=1"
rem		rem echo bad_characters = %bad_characters%
rem	) else (
rem		set "dk_isVariableName=0"
rem	)

	set "_SCOPE_=%~n0"
	for /F "delims=" %%G in ('set %~n0') do (
		if "%_SCOPE_%" equ "%~n0" endlocal
		set "%%G"
	)
	if %dk_isVariableName% equ 0 (
		set /P "=%~1 " <nul
	)
	exit /b %dk_isVariableName%
%endfunction%






rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal DisableDelayedExpansion
	echo __NUL__ %red%FAILED%clr%
	call :dk_isVariableName "____" && (echo %green%PASSED%clr%) || (echo %red%FAILED%clr%)
	call :dk_isVariableName "____" && (echo %green%PASSED%clr%) || (echo %red%FAILED%clr%)
	call :dk_isVariableName "____" && (echo %green%PASSED%clr%) || (echo %red%FAILED%clr%)
	call :dk_isVariableName "____" && (echo %green%PASSED%clr%) || (echo %red%FAILED%clr%)
	call :dk_isVariableName "____" && (echo %green%PASSED%clr%) || (echo %red%FAILED%clr%)
	call :dk_isVariableName "____" && (echo %green%PASSED%clr%) || (echo %red%FAILED%clr%)
	call :dk_isVariableName "____" && (echo %green%PASSED%clr%) || (echo %red%FAILED%clr%)
	call :dk_isVariableName "____"  && (echo %green%PASSED%clr%) || (echo %red%FAILED%clr%)
	

	
	for /F "delims=" %%a in ('cmd /U /C type "X:\Users\Default\Digital Knob\Development\test\ascii.txt" ^| find /V ""') do (echo "%%a")
	
%endfunction%
