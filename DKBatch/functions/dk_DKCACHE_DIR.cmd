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
rem # dk_DKCACHE_DIR()
rem #
rem #
:dk_DKCACHE_DIR
%setlocal%

	rem ############ SET ############
	if "%~1" neq "" (
		set "DKCACHE_DIR=%~1"
	
	rem ############ GET ############
	) else (
		%dk_call% dk_validatePath DIGITALKNOB_DIR %dk_call% dk_DIGITALKNOB_DIR
		set "DKCACHE_DIR=!DIGITALKNOB_DIR!/.dk"	
	)
	
	%dk_call% dk_mkdir "%DKCACHE_DIR%"
	
	endlocal & (
		set "DKCACHE_DIR=%DKCACHE_DIR%"
	)
%endfunction%






rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

	%dk_call% dk_echo
	%dk_call% dk_echo "Test Getting DKCACHE_DIR . . ."
	%dk_call% dk_DKCACHE_DIR
	%dk_call% dk_printVar DKCACHE_DIR
	
	%dk_call% dk_echo
	%dk_call% dk_echo "Test Setting DKCACHE_DIR . . ."
	%dk_call% dk_DKCACHE_DIR "C:/DK/myCache"
	%dk_call% dk_printVar DKCACHE_DIR
%endfunction%
