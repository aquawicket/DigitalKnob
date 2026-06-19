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


rem ################################################################################
rem # dk_saveVars()
rem #
rem #    https://stackoverflow.com/a/41872317/688352
rem #
:dk_saveVars
%setlocal%
	
	rem	rem We need a temporary file to store the original environment
	rem for %%f in ("original_vars.tmp") do (
	rem	rem Retrieve the original environment to the temporary file
	rem	start /i /wait /min "" "%ComSpec%" /c">""%%~ff"" set "
	rem )

	%dk_call% dk_validate DKCACHE_DIR %dk_call% dk_DKCACHE_DIR
	
rem	rem move current_vars to prev_vars
rem	if EXIST "%DKCACHE_DIR%\current_vars.tmp" (
rem	    %dk_call% dk_rename %DKCACHE_DIR%\current_vars.tmp %DKCACHE_DIR%\prev_vars.tmp  OVERWRITE
rem	)

	rem save the current environment variables
	set > %DKCACHE_DIR%/current_vars.tmp
%endfunction%







rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

	%dk_call% dk_saveVars
	%dk_call% dk_echo "variables saved to %DKCACHE_DIR%/current_vars.tmp"
%endfunction%
