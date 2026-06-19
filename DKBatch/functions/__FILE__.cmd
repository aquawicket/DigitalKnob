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
rem # __FILE__(frame)
rem #
rem :__FILE__
rem %setlocal%
rem
	rem if "%_FRAME_%" equ "" (set "_FRAME_=%~1")
	rem if "%_FRAME_%" equ "" (set "_FRAME_=0")
	rem set /a _FRAME_+=1
	
	rem echo "$(basename %BATCH_SOURCE[%_FRAME_%]%"
	rem %dk_call% dk_return "$(basename %BATCH_SOURCE[%_FRAME_%]%"
rem %endfunction%



rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

	echo __FILE__ = %__FILE__%
%endfunction%
