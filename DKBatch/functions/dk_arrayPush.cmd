@echo off
call %DKBATCH_FUNCTIONS_DIR_%DK.cmd

::################################################################################
::# dk_arrayPush(array, element1, element2, /* …, */ elementN)
::#
::#    https://www.w3schools.com/js/js_array_methods.asp#mark_push
::#    https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/push
::#
:dk_arrayPush
	call dk_debugFunc
	if %__ARGC__% neq 2 call dk_error "%__FUNCTION__%:%__ARGV__% incorrect number of arguments"
	
	setlocal
	call dk_arrayLength %~1 end_index
	endlocal & set "%~1[%end_index%]=%~2"
goto:eof




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc
	
	::set "MyArray[0]=a"
	::set "MyArray[1]=b"
	::set "MyArray[2]=c"
	
	call dk_printVar MyArray
	
	call dk_arrayPush MyArray a
	call dk_printVar MyArray
	
	call dk_arrayPush MyArray b
	call dk_printVar MyArray
	
	call dk_arrayPush MyArray c
	call dk_printVar MyArray
	
	call dk_arrayPush MyArray d
	call dk_printVar MyArray
goto:eof
