@echo off
call %DKBATCH_FUNCTIONS_DIR_%DK.cmd

::####################################################################
::# dk_reload()
::#
::#
:dk_reload
	call dk_debugFunc
	if %__ARGC__% neq 0 call dk_error "%__FUNCTION__%:%__ARGV__% incorrect number of arguments"
	
	if not exist "%DKSCRIPT_PATH%" dk_error "DKSCRIPT_PATH is invalid"; goto:eof
	
    dk_echo
    dk_echo "reloading %DKSCRIPT_PATH%"
    start "" "%DKSCRIPT_PATH%" & dk_exit & dk_exit & dk_exit
goto:






::####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ######
:DKTEST
	call dk_debugFunc
	
	call dk_reload
goto:eof
