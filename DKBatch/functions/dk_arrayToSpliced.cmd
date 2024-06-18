@echo off
call DK

::################################################################################
::# dk_arrayToSpliced(array, start, deleteCount, item1, item2, /* …, */ itemN)
::#
::#    https://www.w3schools.com/js/js_array_methods.asp#mark_tospliced
::#    https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/toSpliced
::#
:dk_arrayToSpliced () {
	call dk_debugFunc
	if %__ARGC__% neq 2 (call dk_error "%__FUNCTION__%(%__ARGC__%): incorrect number of arguments")
	
	call dk_todo "dk_arrayToSpliced"
goto:eof




:DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###
	call dk_debugFunc
	
	call dk_todo
goto:eof