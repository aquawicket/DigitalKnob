@echo off
call DK

::################################################################################
::# dk_arrayJoin(<array> <separator> <rtn_var>)
::#
::#    reference: https://www.w3schools.com/js/js_array_methods.asp#mark_join
::#
:dk_arrayJoin () {
	call dk_debugFunc
	if %__ARGC__% neq 3 (call dk_error "%__FUNCTION__%(%__ARGC__%): incorrect number of arguments")
	
	set "_arry_=%~1"
	set "_separator_=%~2"
	set _count_=0
	:dk_arrayJoin_loop
	if defined %_arry_%[%_count_%] (
		if defined _arryStr_ (
			call set "_arryStr_=%_arryStr_%%_separator_%%%%_arry_%[%_count_%]%%"
		) else (
		    call set "_arryStr_=%%%_arry_%[%_count_%]%%"
		)
		set /a _count_+=1
		goto:dk_arrayJoin_loop
	)
	::endlocal & call dk_set %3 "%_arryStr_%"
	endlocal & call set "%3=%_arryStr_%"
goto:eof




:DKTEST ########################################################################

	echo testing dk_arrayAt . . .
	set "MyArray[0]=a"
	set "MyArray[1]=b"
	set "MyArray[2]=c"
	set "MyArray[3]=d"
	set "MyArray[4]=e"
	
	call dk_arrayJoin MyArray "," arrayStr
	echo arrayStr = %arrayStr%