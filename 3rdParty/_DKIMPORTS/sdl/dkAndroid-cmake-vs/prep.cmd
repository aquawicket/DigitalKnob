rem shebang
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


set "DIGITALKNOB_DIR=%USERPROFILE:\=/%/Digital Knob"
set "JAVA_HOME=%DIGITALKNOB_DIR%/Development/3rdParty/openjdk-11_windows-x64_bin"
setx JAVA_HOME %DIGITALKNOB_DIR%/Development/3rdParty/openjdk-11_windows-x64_bin

set APPPATH=%~dp0
if "%APPPATH%" equ "" (set APPPATH=.)
set "GRADLE_USER_HOME=%APPPATH%/gradle"
setx GRADLE_USER_HOME %APPPATH%/gradle

