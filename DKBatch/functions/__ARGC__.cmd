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


rem ############################################################################
rem # __ARGC__(frame)
rem #
rem :__ARGC__
remrem %setlocal%
rem 
rem	if "%_FRAME_%" equ "" (set "_FRAME_=%~1")
rem	if "%_FRAME_%" equ "" (set "_FRAME_=0")
rem 
rem	::set /a _FRAME_+=2
rem	::%dk_call% dk_return "%BATCH_ARGC[%_FRAME_%]%"
rem %endfunction%



rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%


	call :DKTEST_func abc 123
%endfunction%


:DKTEST_func
%setlocal%


	echo __ARGC__ = %__ARGC__%
%endfunction%
