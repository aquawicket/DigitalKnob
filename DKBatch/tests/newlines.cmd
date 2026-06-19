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


:: https://stackoverflow.com/questions/3294599/do-batch-files-support-multiline-variables

::###### newline (echo. version) ######
set \n=^&echo.

:: echo text with newlines
echo first line %\n%second line %\n%third line %\n%

:: variable with newlines (does NOT work with &echo. )
::set multi=Line1%\n%
::set multi=%multi%Line2%\n%
::set multi=%multi%Line3%\n%
::echo %multi%
pause



::###### newline (delayed expansion version) ######
setlocal enableDelayedExpansion
set \n=^


rem two empty line required after set \n
:: echo text with newlines
echo first line !\n!second line !\n!third line !\n!

:: variable with newlines
set multi=Line1!\n!
set multi=!multi!Line2!\n!
set multi=!multi!Line3!\n!
echo !multi!

pause


:: https://stackoverflow.com/a/5642300
::###### newline (without delayed expansion) ######
(set LF=^
%=this line is empty=%
)
echo This text^%LF%%LF%uses two lines
echo This also^

has two lines

pause
