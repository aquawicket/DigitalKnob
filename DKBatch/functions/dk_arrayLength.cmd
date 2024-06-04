@echo off
call DK

::################################################################################
::# dk_arrayLength(<array> <rtn_var>)
::#
::#    reference: https://www.w3schools.com/js/js_array_methods.asp#mark_length
::#
:dk_arrayLength () {
	call dk_debugFunc
	if %__ARGC__% neq 2 (call dk_error "%__FUNCTION__%(%__ARGC__%): incorrect number of arguments")
	
	::call dk_set array_name "%~1"
	call dk_set array_length "0"

	:arrayCountLoop
	if defined %~1[%array_length%] ( 
	   set /a "array_length+=1"
	   goto :arrayCountLoop 
	)
	endlocal & call dk_set %2 "%array_length%"
goto:eof




:DKTEST ########################################################################
