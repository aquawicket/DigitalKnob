@echo off
call DK

::################################################################################
::# dk_arrayToString(array rtn_var)
::#
::#   https://www.w3schools.com/js/js_array_methods.asp#mark_tostring
::#   https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/toString
::#
:dk_arrayToString () {
	call dk_debugFunc
	if %__ARGC__% neq 2 (call dk_error "%__FUNCTION__%(%__ARGC__%): incorrect number of arguments")

	call dk_arrayJoin %~1 "," arrayStr
	endlocal & call dk_set %2 "%arrayStr%"
goto:eof



:DKTEST ########################################################################

	set "MyArray[0]=1"
	set "MyArray[1]=2"
	set "MyArray[2]=3"
	set "MyArray[3]=a"
	set "MyArray[4]=b"
	set "MyArray[5]=c"
	call dk_arrayToString MyArray arryString
	
	echo arryString = %arryString%