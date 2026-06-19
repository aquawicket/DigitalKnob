rem shebang
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

%dk_call% dk_fileVariables "%~dp0/dkconfig.txt"

rem  https://stackoverflow.com/a/67714373
rem %dk_call% dk_validate DKCACHE_DIR %dk_call% dk_DKCACHE_DIR
rem if NOT defined GIT_CONFIG_SYSTEM (set "GIT_CONFIG_SYSTEM=%DKCACHE_DIR%/.gitSystem")
rem if NOT defined GIT_CONFIG_GLOBAL (set "GIT_CONFIG_GLOBAL=%DKCACHE_DIR%/.gitGlobal")

rem ####################################################################
rem # DKUNINSTALL
rem #
rem #
:DKUNINSTALL
%setlocal%

	%dk_call% dk_unimport APP

	%dk_call% dk_uninstall git/contextMenu

%endfunction%






rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	
    %dk_call% DKUNINSTALL
%endfunction%
