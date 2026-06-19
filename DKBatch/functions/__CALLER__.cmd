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
rem # __CALLER__(frame)
rem #
:__CALLER__
%setlocal%

	if "%_FRAME_%" equ "" (set "_FRAME_=%~1")
	if "%_FRAME_%" equ "" (set "_FRAME_=0")
	set /a _FRAME_+=1
	
	rem echo FAME = %_FRAME_%
	rem call dk_set __CALER__ "!FUNCNAME[%_FRAME_%]!()"
	
	call dk_set __CALLER__ !DKSTACK[%_FRAME_%].__FUNCTION__!
	echo __CALLER__ = %__CALLER__%
%endfunction%



rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%


	call __CALLER__
	echo __CALLER__ = %__CALLER__%
%endfunction%
