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

		
::################## DKBuilder ####################
::###### DK_INIT ######
set "DKHTTP_DKBATCH_FUNCTIONS_DIR=http://aquawicket.com/DigitalKnob/Development/DKBatch/functions"
set "DKBATCH_DIR=%CD%\DKBatch"
set "DKBATCH_FUNCTIONS_DIR=%DKBATCH_DIR%\functions"
set "DKBATCH_FUNCTIONS_DIR_=%DKBATCH_DIR%\functions\"
if NOT EXIST "%DKBATCH_FUNCTIONS_DIR%" mkdir "%DKBATCH_FUNCTIONS_DIR%"
if NOT EXIST "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %powershell.exe% -Command "(New-Object Net.WebClient).DownloadFile('%DKHTTP_DKBATCH_FUNCTIONS_DIR%/DK.cmd', '%DKBATCH_FUNCTIONS_DIR_%DK.cmd')"
call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %0


echo Press Y to break
call:function

NEVER REACHED
exit /b

:function
REM WORKS inside cached command block!

FOR /L %%G IN (0) DO (
	echo Loop still in progress...
	choice /C ny /T 1 /D n /N>x
	<x 1>nul 2>nul call :checkify
)
   



:checkify
%ComSpec% /c exit -1073741510