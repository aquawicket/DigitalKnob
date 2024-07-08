@echo off
call %DKBATCH_FUNCTIONS_DIR_%DK.cmd

::################################################################################
::# dk_arrayLength(array, rtn_var)
::#
::#    https://www.w3schools.com/js/js_array_methods.asp#mark_length
::#    https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/length
::#
:dk_arrayLength
	call dk_debugFunc
	if %__ARGC__% neq 2 call dk_error "%__FUNCTION__%:%__ARGV__% incorrect number of arguments"
	
	set _length_=0

	:dk_arrayLength_loop
	if defined %~1[%_length_%] ( 
	   set /a _length_+=1
	   goto :dk_arrayLength_loop 
	)
	endlocal & call dk_set %2 "%_length_%"
goto:eof




::####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ######
:DKTEST
	call dk_debugFunc
	
	set "myArray[0]=a"
	set "myArray[1]=b"
	set "myArray[2]=c"
	set "myArray[3]=d"
	set "myArray[4]=e"
	
	call dk_arrayLength myArray length
	echo length = %length%
goto:eof
