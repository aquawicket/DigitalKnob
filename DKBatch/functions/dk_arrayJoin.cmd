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
	if %__ARGC__% lss 2 call dk_error "%__FUNCTION__%:%__ARGV__% not enough arguments"
	if %__ARGC__% gtr 3 call dk_error "%__FUNCTION__%:%__ARGV__% too many arguments"
	
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
	
	set "myArrayA[0]=a b c"
	set "myArrayA[1]=1 2 3"
	set "myArrayA[2]=d e f"
	set "myArrayA[3]=4 5 6"
	set "myArrayA[4]=h i j"
	
	call dk_arrayJoin myArrayA "," myStringA
	call dk_printVar myStringA
goto:eof
