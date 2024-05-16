@echo off
call DK

::################################################################################
::# dk_arrayToSpliced(<array> <index>)
::#
::#    reference: https://www.w3schools.com/js/js_array_methods.asp#mark_tospliced
::#
:dk_arrayToSpliced () {
	call dk_debugFunc
	if %__ARGC__% NEQ 2 (dk_error "%__FUNCTION__%(): incorrect number of arguments")
	
	call dk_todo "dk_arrayToSpliced"
goto:eof




:DKTEST ########################################################################
