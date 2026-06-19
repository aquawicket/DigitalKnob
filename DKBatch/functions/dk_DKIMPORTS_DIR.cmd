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
rem if NOT defined dk_DKBRANCH_DIR (set "dk_DKBRANCH_DIR=1") else (goto:eof)

rem ###############################################################################
rem # dk_DKIMPORTS_DIR()
rem #
rem #
:dk_DKIMPORTS_DIR
%setlocal%
	
	rem ############ SET ############
	if "%~1" neq "" (
		set "DKIMPORTS_DIR=%~1"
	
	rem ############ GET ############
	) else (
		%dk_call% dk_validate DK3RDPARTY_DIR %dk_call% dk_DK3RDPARTY_DIR
		set "DKIMPORTS_DIR=!DK3RDPARTY_DIR!/_DKIMPORTS"
	)
	
	endlocal & (
		set "DKIMPORTS_DIR=%DKIMPORTS_DIR%"
		set "DK3RDPARTY_DIR=%DK3RDPARTY_DIR%"
	)
	
rem	%dk_call% dk_debug "DKIMPORTS_DIR = %DKIMPORTS_DIR%"
%endfunction%






rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	
	%dk_call% dk_echo
	%dk_call% dk_echo "Test Getting DKIMPORTS_DIR . . ."
	%dk_call% dk_DKIMPORTS_DIR
	%dk_call% dk_echo "DKIMPORTS_DIR = %DKIMPORTS_DIR%"
	
	%dk_call% dk_echo
	%dk_call% dk_echo "Test Setting DKIMPORTS_DIR . . ."
	%dk_call% dk_DKIMPORTS_DIR "C:/DK/myDKImports"
	%dk_call% dk_echo "DKIMPORTS_DIR = %DKIMPORTS_DIR%"
%endfunction%
