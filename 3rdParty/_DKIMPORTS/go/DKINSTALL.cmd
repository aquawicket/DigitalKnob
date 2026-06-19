rem shebang
@echo off&rem ###### DK.cmd #########################################################################################################################
if not defined DKINIT_cmd (
	setlocal enableDelayedExpansion
	if NOT EXIST "%DKBATCH_FUNCTIONS_DIR_%" (set DKBATCH_FUNCTIONS_DIR_=%USERPROFILE:\=/%/Digital Knob/Development/DKBatch/functions/)
	if NOT EXIST "!DKBATCH_FUNCTIONS_DIR_!" for /F "delims=" %%G IN ('dir /b/s/a:-d "%USERPROFILE%\DK.cmd"') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
	call "!DKBATCH_FUNCTIONS_DIR_!DK.cmd" "%~0" %*
	exit /b %errorlevel%
)
rem #################################################################################################################################################


rem ############ go ############
rem # https://go.dev/dl/go1.26.3.windows-amd64.msi

:DKINSTALL
%setlocal%

	%dk_call% dk_import

%endfunction%

