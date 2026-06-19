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


rem ##################################################################################
rem # dk_timeout(seconds)
rem #
rem #    Pause execution and wait for <enter> keypress or until <n> amount of seconds have passed to continue
rem #
:dk_timeout
%setlocal%
   
	if "%~1" equ "" (set "seconds=10") else (set "seconds=%~1")

	%dk_call% timeout.exe %seconds%
	
	endlocal & (
		set "timeout.exe=%timeout.exe%"
	)
%endfunction%






rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
  
    %dk_call% dk_timeout 1
	%dk_call% dk_timeout 5
	%dk_call% dk_timeout
	%dk_call% dk_timeout 3
%endfunction%
