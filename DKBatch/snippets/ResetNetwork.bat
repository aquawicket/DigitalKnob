:: shebang
@echo off&::###### DK.cmd #########################################################################################################################
if not defined DKINIT_cmd (
	setlocal enableDelayedExpansion
	if NOT EXIST "%DKBATCH_FUNCTIONS_DIR_%" (set DKBATCH_FUNCTIONS_DIR_=%USERPROFILE:\=/%/DigitalKnob/Development/DKBatch/functions/)
	if NOT EXIST "!DKBATCH_FUNCTIONS_DIR_!" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
	call "!DKBATCH_FUNCTIONS_DIR_!DK.cmd" "%~0" %*
	exit /b %errorlevel%
)
::#################################################################################################################################################


ipconfig /release
ipconfig /renew
arp -d *
nbtstat -R
nbtstat -RR
ipconfig /flushdns
ipconfig /registerdns