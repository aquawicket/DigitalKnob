@echo off
call DK

::################################################################################
::# dk_arrayAt(<array> <index>)
::#
::#    reference: https://www.w3schools.com/js/js_array_methods.asp#mark_at
::#
:dk_arrayAt () {
	call dk_debugFunc
	if %__ARGC__% NEQ 2 (call dk_error "%__FUNCTION__%(): incorrect number of arguments")
	
	call dk_todo "dk_arrayAt"
goto:eof




:DKTEST ########################################################################
