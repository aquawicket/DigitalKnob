@echo off
call DK

::################################################################################
::# dk_getArrayLength(<array_name> <output>)
::#
::#
:dk_getArrayLength () {

	::set "array_name=%~1"
	set "array_length=0"
	
	:arrayCountLoop
	if defined %~1[%array_length%] ( 
	   set /a "array_length+=1"
	   goto :arrayCountLoop 
	)

	::echo %array_length%
	endlocal & set %2=%array_length% 
 
goto:eof
