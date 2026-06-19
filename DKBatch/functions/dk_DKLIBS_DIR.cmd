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
rem # dk_DKLIBS_DIR()
rem #
rem #
:dk_DKLIBS_DIR
%setlocal%

	rem ############ SET ############
	if "%~1" neq "" (
		set "DKLIBS_DIR=%~1"
	
	rem ############ GET ############
	) else (
		%dk_call% dk_validatePath DIGITALKNOB_DIR %dk_call% dk_DIGITALKNOB_DIR
		set "DKLIBS_DIR=!DIGITALKNOB_DIR!/DKLibs"
	)
	
	%dk_call% dk_mkdir "%DKLIBS_DIR%"
	
	endlocal & (
		set "DKLIBS_DIR=%DKLIBS_DIR%"
	)
%endfunction%






rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

	%dk_call% dk_echo
	%dk_call% dk_echo "Test Getting DKLIBS_DIR . . ."
	%dk_call% dk_DKLIBS_DIR
	%dk_call% dk_echo "DKLIBS_DIR = %DKLIBS_DIR%"
	
	%dk_call% dk_echo
	%dk_call% dk_echo "Test Setting DKLIBS_DIR . . ."
	%dk_call% dk_DKLIBS_DIR "C:/DK/myDKLIBS"
	%dk_call% dk_echo "DKLIBS_DIR = %DKLIBS_DIR%"
%endfunction%
