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
rem # dk_DKTOOLS_DIR()
rem #
rem #
:dk_DKTOOLS_DIR
%setlocal%

	rem ############ SET ############
	if "%~1" neq "" (
		set "DKTOOLS_DIR=%~1"
	
	rem ############ GET ############
	) else (
		%dk_call% dk_validatePath DIGITALKNOB_DIR %dk_call% dk_DIGITALKNOB_DIR
		set "DKTOOLS_DIR=!DIGITALKNOB_DIR!/DKTools"
	)
	
	%dk_call% dk_mkdir "%DKTOOLS_DIR%"
	
	endlocal & (
		set "DKTOOLS_DIR=%DKTOOLS_DIR%"
	)
%endfunction%






rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

	%dk_call% dk_echo
	%dk_call% dk_echo "Test Getting DKTOOLS_DIR . . ."
	%dk_call% dk_DKTOOLS_DIR
	%dk_call% dk_echo "DKTOOLS_DIR = %DKTOOLS_DIR%"
	
	%dk_call% dk_echo
	%dk_call% dk_echo "Test Setting DKTOOLS_DIR . . ."
	%dk_call% dk_DKTOOLS_DIR "C:/DK/myDKTools"
	%dk_call% dk_echo "DKTOOLS_DIR = %DKTOOLS_DIR%"
%endfunction%
