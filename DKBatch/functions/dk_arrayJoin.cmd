@echo off
call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd"

::################################################################################
::# dk_arrayJoin(array, separator, rtn_var)
::#
::#    The join() method of Array instances creates and returns a new string by concatenating all of the elements in this array, separated by commas or a specified separator string. 
::#    If the array has only one item, then that item will be returned without using the separator.
::#
::#    PARAMETERS
::#    separator :optional
::#        A string to separate each pair of adjacent elements of the array. If omitted, the array elements are separated with a comma (",").
::#
::#    RETURN VALUE
::#    A string with all array elements joined. If array.length is 0, the empty string is returned.
::#
::#    REFERENCE
::#    https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/join
::#
:dk_arrayJoin
	call dk_debugFunc
	if %__ARGC__% neq 3 call dk_error "%__FUNCTION__%:%__ARGV__% incorrect number of arguments"
	
	setlocal
	::set "_arry_=%~1"
	::set "_separator_=%~2"
	set _count_=0
	:dk_arrayJoin_loop
	if defined %~1[%_count_%] (
		if defined _string_ (
			if "!!" equ "" set "_string_=%_string_%%~2!%~1[%_count_%]!"
			if "!!" neq "" call set "_string_=%_string_%%~2%%%~1[%_count_%]%%"
		) else (
			if "!!" equ "" set "_string_=!%~1[%_count_%]!"
		    if "!!" neq "" call set "_string_=%%%~1[%_count_%]%%"
		)
		set /a _count_+=1
		goto:dk_arrayJoin_loop
	)
	endlocal & set "%3=%_string_%"
goto:eof




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc
	
	set "myArray[0]=a"
	set "myArray[1]=b"
	set "myArray[2]=c"
	set "myArray[3]=d"
	set "myArray[4]=e"
	
	call dk_arrayJoin myArray "," myString
	call dk_printVar myString
goto:eof
