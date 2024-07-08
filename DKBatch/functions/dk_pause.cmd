@echo off
call %DKBATCH_FUNCTIONS_DIR_%DK.cmd

::##################################################################################
::# dk_pause()
::#
::#    Pause execution and wait for <enter> keypress to continue
::#
:dk_pause
	call dk_debugFunc
	if %__ARGC__% neq 0 call dk_error "%__FUNCTION__%:%__ARGV__% incorrect number of arguments"
	
	pause
goto:eof






::####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST #######
:DKTEST
	call dk_debugFunc
	
	call dk_pause
goto:eof
