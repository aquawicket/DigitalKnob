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
rem # DKHOME_DIR()
rem #
rem #
:DKHOME_DIR
%setlocal%

	rem ############ SET ############
	if "%~1" neq "" (
		set "DKHOME_DIR=%~1"
	
	rem ############ GET ############
	) else (
		set "DKHOME_DIR=%USERPROFILE:\=/%"
	)	
		
	%dk_call% dk_assertPath DKHOME_DIR
		
	rem ### DKHTTP_DKHOME_DIR ###
	set "DKHTTP_DKHOME_DIR=http://aquawicket.com"

	:return
	endlocal & (
		set "DKHOME_DIR=%DKHOME_DIR%"
		set "DKHTTP_DKHOME_DIR=%DKHTTP_DKHOME_DIR%"
	)
%endfunction%



rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

	%dk_call% dk_echo
	%dk_call% dk_echo "Test Getting DKHOME_DIR . . ."
	%dk_call% DKHOME_DIR
	%dk_call% dk_echo "DKHOME_DIR = %DKHOME_DIR%"
	
	%dk_call% dk_echo
	%dk_call% dk_echo "Test Setting DKHOME_DIR . . ."
	%dk_call% DKHOME_DIR "C:\Users\aquawicket"
	%dk_call% dk_echo "DKHOME_DIR = %DKHOME_DIR%"
%endfunction%
