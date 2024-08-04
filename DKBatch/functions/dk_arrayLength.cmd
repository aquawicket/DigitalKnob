@echo off
call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd"

::################################################################################
::# dk_arrayLength(array)
::# dk_arrayLength(array rtn_var)
::#
::#    The length data property of an Array instance represents the number of elements in that array. 
::#    The value is an unsigned, 32-bit integer that is always numerically greater than the highest index in the array.
::#
::#    REFERENCE
::#    https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/length
::#
:dk_arrayLength
	call dk_debugFunc
	call dk_minMaxArgs 2
	::if %__ARGC__% neq 2 call dk_error "%__FUNCTION__%:%__ARGV__% incorrect number of arguments"
	
	setlocal
	set _length_=0
	:dk_arrayLength_loop
	if defined %~1[%_length_%] ( 
	   set /a _length_+=1
	   goto :dk_arrayLength_loop 
	)
	endlocal & set "%2=%_length_%"
goto:eof




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc
	call dk_minMaxArgs 0
	
	set "myArrayA[0]=a b c"
	set "myArrayA[1]=1 2 3"
	set "myArrayA[2]=d e f"
	set "myArrayA[3]=4 5 6"
	set "myArrayA[4]=h i j"
	
	call dk_arrayLength myArrayA myArrayLengthA
	call dk_printVar myArrayLengthA
goto:eof
