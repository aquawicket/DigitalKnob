@echo off
call DK

::####################################################################
::# dk_sleep(seconds)
::#
:dk_sleep () {
	call dk_debugFunc
	if %__ARGC__% neq 1 (call dk_error "%__FUNCTION__%(%__ARGC__%): incorrect number of arguments")
	
	set /a N=%1+1
	ping -n %N% 127.0.0.1 >nul 2>&1
goto:eof




:DKTEST ############################## DKTEST ##############################
