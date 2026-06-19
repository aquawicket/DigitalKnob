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


rem ###############################################################################
rem # dk_DK3RDPARTY_DIR()
rem #
rem #
:dk_DK3RDPARTY_DIR
%setlocal%
	
	rem ###### SET ######
	if "%~1" neq "" (
		set "DK3RDPARTY_DIR=%~1"
	
	rem ###### GET ######
	) else (
		%dk_call% dk_validate DKBRANCH_DIR %dk_call% dk_DKBRANCH_DIR
		set "DK3RDPARTY_DIR=!DKBRANCH_DIR!/3rdParty"
	)
	
	endlocal & (
		set "DK3RDPARTY_DIR=%DK3RDPARTY_DIR%"
		set "DKBRANCH_DIR=%DKBRANCH_DIR%"
	)
	
rem	%dk_call% dk_debug "DK3RDPARTY_DIR = %DK3RDPARTY_DIR%"
%endfunction%






rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	
	%dk_call% dk_echo
	%dk_call% dk_echo "Test Getting DK3RDPARTY_DIR . . ."
	%dk_call% dk_DK3RDPARTY_DIR
	%dk_call% dk_echo "DK3RDPARTY_DIR = %DK3RDPARTY_DIR%"
	
	%dk_call% dk_echo
	%dk_call% dk_echo "Test Setting DK3RDPARTY_DIR . . ."
	%dk_call% dk_DK3RDPARTY_DIR "C:/DK/my3rdParty"
	%dk_call% dk_echo "DK3RDPARTY_DIR = %DK3RDPARTY_DIR%"
%endfunction%
