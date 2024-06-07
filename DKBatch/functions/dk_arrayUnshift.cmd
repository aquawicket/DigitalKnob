@echo off
call DK

::###################################################################################################
::# dk_arrayUnshift(array, element1, element2, /* …, */ elementN)
::#
::#    https://www.w3schools.com/js/js_array_methods.asp#mark_unshift
::#    https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/unshift
::#
:dk_arrayUnshift () {
	call dk_debugFunc
	if %__ARGC__% neq 2 (call dk_error "%__FUNCTION__%(%__ARGC__%): incorrect number of arguments")
	
	set "_arry_=%~1"
	::set "_value_=%~2"
	
	call dk_arrayLength %~1 count
	set /a prev=count-1
	
	:dk_arrayUnshift_loop
	if %count% gtr 0 (
		call set "%_arry_%[%count%]=%%%_arry_%[%prev%]%%"
		set /a count-=1
		set /a prev-=1
		goto:dk_arrayUnshift_loop
	)
	endlocal & call dk_set %~1[0] "%~2"
goto:eof




:DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###

	set "MyArray[0]=c"
	set "MyArray[1]=d"
	set "MyArray[2]=e"
	
	call dk_printArray MyArray
	call dk_arrayUnshift MyArray b
	call dk_printArray MyArray
	