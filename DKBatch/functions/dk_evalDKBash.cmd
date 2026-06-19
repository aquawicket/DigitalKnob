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


rem ############################################################################
rem # dk_evalDKBash(code)
rem #
rem #
:dk_evalDKBash
%setlocal%

	%dk_call% dk_validate DKCACHE_DIR %dk_call% dk_DKCACHE_DIR
	echo %~1 > "%DKCACHE_DIR%/dk_evalDKBash_TEMP.sh"
	
	%dk_call% dk_validate bash_exe %dk_call% dk_depend bash_exe
	set DKCOMMAND=%bash_exe% -c "%DKCACHE_DIR%/dk_evalDKBash_TEMP.sh";
	%dk_call% dk_exec %DKCOMMAND%
	endlocal & (
		set "dk_evalDKBash=%dk_exec%"
	)
%endfunction%











rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

	%dk_call% dk_evalDKBash "echo 'testing dk_evalDKBash'"
	
	rem ### Print Shell Path and Version ###
rem	%dk_call% dk_evalDKBash
rem	(
rem		"export ESC="";  # escape character
rem		[ -n "${BASH-}" ] && export DKSHELL_PATH=${BASH-}; || export DKSHELL_PATH=${SHELL-};
rem		export DKSHELL=$(basename ${DKSHELL_PATH});
rem		export DKSHELL_VERSION="$($DKSHELL_PATH --help 2>&1 | head -1)";
rem		echo "";
rem		echo "${ESC}[45m ${ESC}[30m ${DKSHELL} Version ${DKSHELL_VERSION} ${ESC}[0m";
rem		echo "DKSHELL_PATH  ${DKSHELL_PATH}";
rem		echo "DKSCRIPT_PATH  ${DKSCRIPT_PATH-}";
rem		echo "";
rem	)
%endfunction%

