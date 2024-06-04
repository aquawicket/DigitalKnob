@echo off
call DK

::################################################################################
::# dk_arrayToSpliced(<array> <index>)
::#
::#    reference: https://www.w3schools.com/js/js_array_methods.asp#mark_tospliced
::#
:dk_arrayToSpliced () {
	call dk_debugFunc
	if %__ARGC__% neq 2 (call dk_error "%__FUNCTION__%(%__ARGC__%): incorrect number of arguments")
	
	call dk_todo "dk_arrayToSpliced"
goto:eof




:DKTEST ########################################################################
