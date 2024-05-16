@echo off
call DK

::################################################################################
::# dk_arrayLength(<array> <output>)
::#
::#    reference: https://www.w3schools.com/js/js_array_methods.asp#mark_length
::#
:dk_arrayLength () {
	call dk_debugFunc
	if %__ARGC__% NEQ 2 (dk_error "%__FUNCTION__%(): incorrect number of arguments")
	
	::set "array_name=%~1"
	set "array_length=0"

	:arrayCountLoop
	if defined %~1[%array_length%] ( 
	   set /a "array_length+=1"
	   goto :arrayCountLoop 
	)
	endlocal & set "%2=%array_length%"
goto:eof




:DKTEST ########################################################################
