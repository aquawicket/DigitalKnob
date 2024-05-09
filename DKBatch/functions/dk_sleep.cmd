@echo off
call DK

::####################################################################
::# dk_sleep(<seconds>)
::#
:dk_sleep () {
	call dk_debugFunc
	if "%~1" equ "" call dk_error "%__FUNCTION__%(%*): argument 1 is invalid"
	
	set /a N=%1+1
	ping -n %N% 127.0.0.1 >nul 2>&1
goto:eof




:DKTEST ############################## DKTEST ##############################
