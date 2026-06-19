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


rem ####################################################################
rem # dk_DKDESKTOP_DIR()
rem #
rem #
:dk_DKDESKTOP_DIR
%setlocal%

	rem ############ SET ############
	if "%~1" neq "" (
		set "DKDESKTOP_DIR=%~1"
	
	rem ############ GET ############
	) else (
		%dk_call% dk_validatePath DKHOME_DIR %dk_call% DKHOME_DIR
		set "DKDESKTOP_DIR=!DKHOME_DIR!/Desktop"
	)
	
	endlocal & (
		set "DKDESKTOP_DIR=%DKDESKTOP_DIR%"
	)
%endfunction%






rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

	%dk_call% dk_echo
	%dk_call% dk_echo "Test Getting DKDESKTOP_DIR . . ."
	%dk_call% dk_DKDESKTOP_DIR
	%dk_call% dk_echo "DKDESKTOP_DIR = %DKDESKTOP_DIR%"
	
	%dk_call% dk_echo
	%dk_call% dk_echo "Test Setting DKDESKTOP_DIR . . ."
	%dk_call% dk_DKDESKTOP_DIR "C:/DK/myDesktop"
	%dk_call% dk_echo "DKDESKTOP_DIR = %DKDESKTOP_DIR%"
%endfunction%
