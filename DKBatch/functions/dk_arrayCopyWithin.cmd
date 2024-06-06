@echo off
call DK

::################################################################################
::# dk_arrayCopyWithin(array, target, start, end)
::#
::#    https://www.w3schools.com/js/js_array_methods.asp#mark_copywithin
::#    https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/copyWithin
::#
:dk_arrayCopyWithin () {
	call dk_debugFunc
	if %__ARGC__% neq 2 (call dk_error "%__FUNCTION__%(%__ARGC__%): incorrect number of arguments")
	
	call dk_todo "dk_arrayCopyWithin"
goto:eof




:DKTEST ########################################################################

	:: TODO
	:: call dk_arrayCopyWithin