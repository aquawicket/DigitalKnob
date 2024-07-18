@echo off
call %DKBATCH_FUNCTIONS_DIR_%DK.cmd

::####################################################################
::# dk_resetApps()
::#
::#
:dk_resetApps
	call dk_debugFunc
	if %__ARGC__% neq 0 call dk_error "%__FUNCTION__%:%__ARGV__% incorrect number of arguments"
	
    echo Resetting Apps . . .

	call dk_confirm || goto:eof
	
    cd %DKAPPS_DIR%
    "%GIT_EXE%" clean -f -d
goto:eof





::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc
	
	call dk_resetApps
goto:eof
