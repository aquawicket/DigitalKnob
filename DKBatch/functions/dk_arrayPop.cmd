@echo off
call DK

::################################################################################
::# dk_arrayPop(<array> <index>)
::#
::#    reference: https://www.w3schools.com/js/js_array_methods.asp#mark_pop
::#
:dk_arrayPop () {
	call dk_debugFunc
	if %__ARGC__% neq 2 (call dk_error "%__FUNCTION__%(%__ARGC__%): incorrect number of arguments")
	
	call dk_todo "dk_arrayPop"
goto:eof




:DKTEST ########################################################################
