@echo off
call DK

::################################################################################
::# dk_arraySlice(array, start, end)
::#
::#    https://www.w3schools.com/js/js_array_methods.asp#mark_slice
::#    https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/slice
::#
:dk_arraySlice () {
	call dk_debugFunc
	if %__ARGC__% neq 2 (call dk_error "%__FUNCTION__%(%__ARGC__%): incorrect number of arguments")
	
	call dk_todo "dk_arraySlice"
goto:eof




:DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###
	call dk_debugFunc
	
	call dk_todo
goto:eof