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

:main
%setlocal%
	call :PrintLine UniqueID_A

	call :PrintLine UniqueID_B

	call :PrintLine UniqueID_C
%endfunction%





::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:PrintLine <xUniqueID>
%setlocal%
	:: Find and print _LINE_ number of the unique id
	for /f "usebackq tokens=1 delims=:" %%i in (`findstr /n /c:" %~1" "%~f0"`) do set /a _LINE_=%%~i
	echo "%~1 line:'%_LINE_%'"
	endlocal & (
		set "_LINE_=%_LINE_%"
	)
%endfunction%







rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

	call :main
%endfunction%

