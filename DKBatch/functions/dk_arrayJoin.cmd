@echo off
call DK

::################################################################################
::# dk_arrayJoin(array, separator, string>)
::#
::#    https://www.w3schools.com/js/js_array_methods.asp#mark_join
::#    https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/join
::#
:dk_arrayJoin () {
	call dk_debugFunc
	if %__ARGC__% neq 3 (call dk_error "%__FUNCTION__%(%__ARGC__%): incorrect number of arguments")
	
	::set "_arry_=%~1"
	::set "_separator_=%~2"
	set _count_=0
	:dk_arrayJoin_loop
	if defined %~1[%_count_%] (
		if defined _string_ (
			call set "_string_=%_string_%%~2%%%~1[%_count_%]%%"
		) else (
		    call set "_string_=%%%~1[%_count_%]%%"
		)
		set /a _count_+=1
		goto:dk_arrayJoin_loop
	)
	::endlocal & call dk_set %3 "%_string_%"
	endlocal & call set "%3=%_string_%"
goto:eof




:DKTEST ########################################################################

	set "array[0]=a"
	set "array[1]=b"
	set "array[2]=c"
	set "array[3]=d"
	set "array[4]=e"
	
	call dk_arrayJoin array "," string
	echo string = %string%