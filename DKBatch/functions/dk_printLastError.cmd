@echo off&::###### DK.cmd #########################################################################################################################
if NOT defined DKBATCH_FUNCTIONS_DIR_ (set DKBATCH_FUNCTIONS_DIR_=%USERPROFILE%/DigitalKnob/Development/DKBatch/functions/)
if NOT EXIST "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if NOT defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


::################################################################################
::# dk_printLastError()
::#
:dk_printLastError

	if "%LAST_STATUS%" equ "0"	echo %LAST_FUNC%(%LAST_ARGV%): %green%%LAST_STATUS% '%LAST_MESSAGE%' %clr%
	if "%LAST_STATUS%" neq "0"	echo %LAST_FUNC%(%LAST_ARGV%): %red%%LAST_STATUS% '%LAST_MESSAGE%' %clr%
	::if "%LAST_STATUS%" neq "0" call dk_error "%LAST_FUNC%(%LAST_ARGV%): %LAST_STATUS% '%LAST_MESSAGE%' %clr%"

::call exit /b %LAST_STATUS%