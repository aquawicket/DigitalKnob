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
::# Powershell environment
::#
%dk_call% dk_validate powershell.exe %dk_call% dk_depend powershell.exe
%dk_call% dk_validate DKPOWERSHELL_FUNCTIONS_DIR %dk_call% dk_depend dk_DKBRANCH_DIR
%powershell.exe% -Command ^
. %DKPOWERSHELL_FUNCTIONS_DIR%/DK.ps1
dk_call dk_clearScreen ^
dk_call dk_title "Digitalknob DK_POWERSHELL" ^
dk_call dk_echo "############ DK_POWERSHELL environment ############" ^
dk_call dk_echo "" ^

