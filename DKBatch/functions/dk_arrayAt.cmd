@echo off
call %DKBATCH_FUNCTIONS_DIR_%DK.cmd

::################################################################################
::# dk_arrayAt(array, index, element)
::#
::#    https://www.w3schools.com/js/js_array_methods.asp#mark_at
::#    https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/at
::#
:dk_arrayAt () {
	call dk_debugFunc
	if %__ARGC__% neq 3 (call dk_error "%__FUNCTION__%(%__ARGC__%): incorrect number of arguments")
	
	endlocal & call dk_set %3 "%%%~1[%~2]%%"
goto:eof



::####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###
:DKTEST
	call dk_debugFunc
	
	set "MyArray[0]=a"
	set "MyArray[1]=b"
	set "MyArray[2]=c"
	set "MyArray[3]=d"
	set "MyArray[4]=e"
	
	call dk_arrayAt MyArray 3 element
	call dk_echo "element = %element%"
goto:eof
