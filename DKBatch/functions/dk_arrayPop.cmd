@echo off
call DK

::################################################################################
::# dk_arrayPop(<array> <index>)
::#
::#    reference: https://www.w3schools.com/js/js_array_methods.asp#mark_pop
::#
:dk_arrayPop () {
	call dk_debugFunc
	if %__ARGC__% NEQ 2 (dk_error "%__FUNCTION__%(): incorrect number of arguments")
	
	call dk_todo "dk_arrayPop"
goto:eof




:DKTEST ########################################################################