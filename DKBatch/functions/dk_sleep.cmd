@echo off
call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd"

::####################################################################
::# dk_sleep(seconds)
::#
:dk_sleep
	call dk_debugFunc
	if %__ARGC__% neq 1 call dk_error "%__FUNCTION__%:%__ARGV__% incorrect number of arguments"
	
	set /a N=%1+1
	ping -n %N% 127.0.0.1 >nul 2>&1
goto:eof



::############################ DKTEST ############################
:DKTEST
	call dk_debugFunc
	
	call dk_echo "sleeping for 10 seconds . . ."
	call dk_sleep 10
goto:eof
