@echo off
call DK

::################################################################################
::# dk_arrayUnshift(<array> <value>)
::#
::#    reference: https://www.w3schools.com/js/js_array_methods.asp#mark_unshift
::#   
::#   Note:  expand array element by _arrayName_ name and _number_
::#			 call echo %%%_arrayName_%[%_number_%]%%
::#
:dk_arrayUnshift () {
	call dk_debugFunc
	if %__ARGC__% neq 2 (call dk_error "%__FUNCTION__%(%__ARGC__%): incorrect number of arguments")
	
	set "_arry_=%~1"
	set "_value_=%~2"
	
	call dk_arrayLength %_arry_% count
	set /a prev=count-1
	
	:dk_arrayUnshift_loop
	if %count% gtr 0 (
		::echo count = %count%
		::echo prev = %prev%
		call set "%_arry_%[%count%]=%%%_arry_%[%prev%]%%"
		::call echo %_arry_%[%count%] = %%%_arry_%[%count%]%%
		set /a count-=1
		set /a prev-=1
		goto:dk_arrayUnshift_loop
	)
	endlocal & call dk_set %_arry_%[0] "%~2"
goto:eof




:DKTEST ########################################################################

	echo testing dk_arrayUnshift . . .
	set "MyArray[0]=c"
	set "MyArray[1]=d"
	set "MyArray[2]=e"
	
	call dk_printArray MyArray
	call dk_arrayUnshift MyArray b
	call dk_printArray MyArray
	