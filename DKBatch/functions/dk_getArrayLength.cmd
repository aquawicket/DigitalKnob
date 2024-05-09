@echo off
call DK

::################################################################################
::# dk_getArrayLength(<array_name> <output>)
::#
::#
:dk_getArrayLength () {
	call dk_debugFunc
	if "%~1" equ "" call dk_error "%__FUNCTION__%(%*): argument 1 is invalid"
	if "%~2" equ "" call dk_error "%__FUNCTION__%(%*): argument 2 is invalid"
	if "%~3" neq "" call dk_error "%__FUNCTION__%(%*): too many arguments"
	
	::set "array_name=%~1"
	set "array_length=0"

	:arrayCountLoop
	if defined %~1[%array_length%] ( 
	   set /a "array_length+=1"
	   goto :arrayCountLoop 
	)
	endlocal & set %2=%array_length%  
goto:eof
