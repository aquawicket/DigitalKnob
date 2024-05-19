@echo off
call DK

::################################################################################
::# dk_arrayCopyWithin(<array> <index>)
::#
::#    reference: https://www.w3schools.com/js/js_array_methods.asp#mark_copywithin
::#
:dk_arrayCopyWithin () {
	call dk_debugFunc
	if %__ARGC__% NEQ 2 (call dk_error "%__FUNCTION__%(%__ARGC__%): incorrect number of arguments")
	
	call dk_todo "dk_arrayCopyWithin"
goto:eof




:DKTEST ########################################################################
