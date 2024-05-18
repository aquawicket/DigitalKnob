@echo off
call DK

::################################################################################
::# dk_arrayFlat(<array> <index>)
::#
::#    reference: https://www.w3schools.com/js/js_array_methods.asp#mark_flat
::#
:dk_arrayFlat () {
	call dk_debugFunc
	if %__ARGC__% NEQ 2 (call dk_error "%__FUNCTION__%(): incorrect number of arguments")
	
	call dk_todo "dk_arrayFlat"
goto:eof




:DKTEST ########################################################################
