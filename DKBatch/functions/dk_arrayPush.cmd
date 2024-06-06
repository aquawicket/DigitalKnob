@echo off
call DK

::################################################################################
::# dk_arrayPush(array, element1, element2, /* …, */ elementN)
::#
::#    https://www.w3schools.com/js/js_array_methods.asp#mark_push
::#    https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/push
::#
:dk_arrayPush () {
	call dk_debugFunc
	if %__ARGC__% neq 2 (call dk_error "%__FUNCTION__%(%__ARGC__%): incorrect number of arguments")
	
	call dk_arrayLength %~1 end_index
	endlocal & call dk_set %~1[%end_index%] "%~2"
goto:eof




:DKTEST ########################################################################

	set "MyArray[0]=a"
	set "MyArray[1]=b"
	set "MyArray[2]=c"
	
	call dk_printArray MyArray
	
	call dk_arrayPush MyArray d
	call dk_printArray MyArray
	
	call dk_arrayPush MyArray e
	call dk_printArray MyArray
	
	call dk_arrayPush MyArray f
	call dk_printArray MyArray