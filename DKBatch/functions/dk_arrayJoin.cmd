@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd"

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
	call dk_debugFunc 3
	::dk_validateArgs array string optional:rtn_var
	
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
	call dk_debugFunc 0
	
	set "myArrayA[0]=a b c"
	set "myArrayA[1]=1 2 3"
	set "myArrayA[2]=d e f"
	set "myArrayA[3]=4 5 6"
	set "myArrayA[4]=h i j"
	
	call dk_arrayJoin myArrayA "," myStringA
	call dk_printVar myStringA
	
	
	set "myArrayB[0]=h i j"
	set "myArrayB[1]=4 5 6"
	set "myArrayB[2]=d e f"
	set "myArrayB[3]=1 2 3"
	set "myArrayB[4]=a b c"
	
	call dk_arrayJoin myArrayB "," myStringB
	::myStringB=$(dk_arrayJoin myArrayB ",")
	call dk_printVar myStringB
goto:eof
