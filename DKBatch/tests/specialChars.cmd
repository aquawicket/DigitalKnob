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



setlocal
::call :setVar (^.*)(Form Product=")([^"]*") FormType="[^"]*" FormID="([0-9][0-9]*)".*$
call :setVar "' ` ( ) ! \ / [ ] . ^ , ; = ? | < > & * ~ @ $ % ^ { } - _ "
::call :setVar "' ` ( ) ! \ / [ ] . ^ , ; = ? | < > & * ~ @ $ % ^ # { } - _ #"

setLocal EnableDelayedExpansion
echo setVar = '!setVar!'
pause
goto :eof



:: Search the own batch file for <searchName> in a line with "call :setVar "
:setVar <resultVar> <searchName>
	setLocal DisableDelayedExpansion
	for /f "usebackq tokens=* delims=" %%G in (`findstr /B /c:"call :setVar " "%~f0"`) do (
		set "str=%%G"
	)
	setLocal EnableDelayedExpansion
	set str=!str:call :setVar =!
	echo !str!
	set "str=!str:*#=!"
	for /F "delims=" %%A in ("!str!") DO (
	  endlocal
	  endlocal
	  set "setVar=%%A"
	  goto :eof
	)

	pause
goto :eof