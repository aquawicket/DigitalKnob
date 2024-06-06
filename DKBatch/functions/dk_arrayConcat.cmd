@echo off
call DK

::################################################################################
::# dk_arrayConcat(array, value1, value2, /* …, */ valueN)
::#
::#    https://www.w3schools.com/js/js_array_methods.asp#mark_concat
::#    https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/concat
::#
:dk_arrayConcat () {
	call dk_debugFunc
	if %__ARGC__% neq 2 (call dk_error "%__FUNCTION__%(%__ARGC__%): incorrect number of arguments")
	
	call dk_todo "dk_arrayConcat"
goto:eof




:DKTEST ########################################################################

	:: TODO
	:: call dk_arrayConcat array value1