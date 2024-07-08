@echo off
call %DKBATCH_FUNCTIONS_DIR_%DK.cmd

::################################################################################
::# dk_arrayCopyWithin(array, target, start, end)
::#
::#    https://www.w3schools.com/js/js_array_methods.asp#mark_copywithin
::#    https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/copyWithin
::#
:dk_arrayCopyWithin
	call dk_debugFunc
	if %__ARGC__% neq 4 call dk_error "%__FUNCTION__%:%__ARGV__% incorrect number of arguments"
	
	call dk_todo %__FUNCTION__%
goto:eof




::####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ######
:DKTEST
	call dk_debugFunc

	call dk_arrayCopyWithin array target start end
goto:eof
