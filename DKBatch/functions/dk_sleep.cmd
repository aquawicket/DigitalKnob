@echo off
call DK

::####################################################################
::# dk_sleep(<seconds>)
::#
:dk_sleep () {
	call dk_debugFunc
	if "%~1" == "" call dk_error "dk_sleep(): parameter 1 invalid"
	
	set /a N=%1+1
	ping -n %N% 127.0.0.1 >nul 2>&1
goto:eof




:DKTEST ############################## DKTEST ##############################
