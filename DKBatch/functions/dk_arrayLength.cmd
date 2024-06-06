@echo off
call DK

::################################################################################
::# dk_arrayLength(array, length>)
::#
::#    https://www.w3schools.com/js/js_array_methods.asp#mark_length
::#    https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/length
::#
:dk_arrayLength () {
	call dk_debugFunc
	if %__ARGC__% neq 2 (call dk_error "%__FUNCTION__%(%__ARGC__%): incorrect number of arguments")
	
	::set _arry_ %~1
	set _length_=0

	:dk_arrayLength_loop
	if defined %~1[%_length_%] ( 
	   set /a _length_+=1
	   goto :dk_arrayLength_loop 
	)
	endlocal & call dk_set %2 "%_length_%"
goto:eof




:DKTEST ########################################################################

	set "array[0]=a"
	set "array[1]=b"
	set "array[2]=c"
	set "array[3]=d"
	set "array[4]=e"
	
	call dk_arrayLength array length
	echo length = %length%