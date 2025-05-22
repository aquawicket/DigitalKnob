@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


::############################################################################
::# dk_evalDKBash()
::#
::#
:dk_evalDKBash
%setlocal%
	%dk_call% dk_debugFunc 0

	%dk_call% dk_validate DKCACHE_DIR "%dk_call% dk_DKCACHE_DIR"
	echo %~1 > "%DKCACHE_DIR%/dk_evalDKBash_TEMP.sh"
	
	%dk_call% dk_validate BASH_EXE "%dk_call% dk_BASH_EXE"
	set DKCOMMAND=%BASH_EXE% -c "%DKCACHE_DIR%/dk_evalDKBash_TEMP.sh";
	%dk_call% dk_exec %DKCOMMAND%
	endlocal & (
		set "dk_evalDKBash=%dk_exec%"
	)

%endfunction%











::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0

	%dk_call% dk_evalDKBash "echo 'testing dk_evalDKBash'"
	
	::### Print Shell Path ad Version ###
	%dk_call% dk_evalDKBash
	(
		"export ESC="";  # escape character
		[ -n "${BASH-}" ] && export DKSHELL_PATH=${BASH-} || export DKSHELL_PATH=${SHELL-}
		export DKSHELL=$(basename ${DKSHELL_PATH})
		export DKSHELL_VERSION="$($DKSHELL_PATH --help 2>&1 | head -1)"
		echo ""
		echo "${ESC}[45m ${ESC}[30m ${DKSHELL} Version ${DKSHELL_VERSION} ${ESC}[0m"
		echo "DKSHELL_PATH  ${DKSHELL_PATH}"
		echo "DKSCRIPT_PATH  ${DKSCRIPT_PATH-}"
		echo ""
	)

%endfunction%

