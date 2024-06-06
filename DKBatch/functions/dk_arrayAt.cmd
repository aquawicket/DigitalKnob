@echo off
call DK

::################################################################################
::# dk_arrayAt(<array> <index> <rtn_var>)
::#
::#    reference: https://www.w3schools.com/js/js_array_methods.asp#mark_at
::#
:dk_arrayAt () {
	call dk_debugFunc
	if %__ARGC__% neq 3 (call dk_error "%__FUNCTION__%(%__ARGC__%): incorrect number of arguments")
	
	endlocal & call dk_set %3 "%%%~1[%~2]%%"
goto:eof




:DKTEST ########################################################################

	echo testing dk_arrayAt . . .
	set "MyArray[0]=a"
	set "MyArray[1]=b"
	set "MyArray[2]=c"
	set "MyArray[3]=d"
	set "MyArray[4]=e"
	
	call dk_arrayAt MyArray 3 arrayAt
	echo arrayAt = %arrayAt%