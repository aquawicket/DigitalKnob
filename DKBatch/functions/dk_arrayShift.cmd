@echo off
call DK

::################################################################################
::# dk_arrayShift(<array> <index>)
::#
::#    reference: https://www.w3schools.com/js/js_array_methods.asp#mark_push
::#
:dk_arrayShift () {
	call dk_debugFunc
	if %__ARGC__% NEQ 2 (dk_error "%__FUNCTION__%(): incorrect number of arguments")
	
	call dk_todo "dk_arrayShift"
goto:eof




:DKTEST ########################################################################