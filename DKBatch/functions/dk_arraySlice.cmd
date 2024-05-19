@echo off
call DK

::################################################################################
::# dk_arraySlice(<array> <index>)
::#
::#    reference: https://www.w3schools.com/js/js_array_methods.asp#mark_slice
::#
:dk_arraySlice () {
	call dk_debugFunc
	if %__ARGC__% NEQ 2 (call dk_error "%__FUNCTION__%(%__ARGC__%): incorrect number of arguments")
	
	call dk_todo "dk_arraySlice"
goto:eof




:DKTEST ########################################################################
