@echo off
call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd"

::################################################################################
::# dk_arrayPop(array)
::# dk_arrayPop(array, rtn_var)
::#
::#    The pop() method of Array instances removes the last element from an array and returns that element. This method changes the length of the array.
::#
::#    PARAMETERS
::#    array
::#
::#	 RETURN VALUE
::#    The removed element from the array; undefined if the array is empty.
::#
::#    REFERENCE
::#    https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/pop
::#
:dk_arrayPop
	call dk_debugFunc
	if %__ARGC__% neq 1 call dk_error "%__FUNCTION__%:%__ARGV__% incorrect number of arguments"
	
	setlocal
	call dk_arrayLength %~1 _length_
	set /a _length_-=1
	call dk_unset %~1[%_length_%]
	endlocal
goto:eof




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc
	
	set "myArray[0]=a"
	set "myArray[1]=b"
	set "myArray[2]=c"
	set "myArray[3]=d"
	set "myArray[4]=e"
	
	call dk_printVar myArray
	
	call dk_arrayPop myArray
	call dk_printVar myArray
	
	call dk_arrayPop myArray
	call dk_printVar myArray
	
	call dk_arrayPop myArray
	call dk_printVar myArray
	
	call dk_arrayPop myArray
	call dk_printVar myArray
	
	call dk_arrayPop myArray
	call dk_printVar myArray
	
	call dk_arrayPop myArray
	call dk_printVar myArray
	
	call dk_arrayPop myArray
	call dk_printVar myArray
	
	call dk_arrayPop myArray
	call dk_printVar myArray
goto:eof
