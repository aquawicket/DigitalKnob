@echo off
call DK

::################################################################################
::# dk_arrayToString(<array_name> <rtn_var>)
::#
::#   reference: https://www.w3schools.com/js/js_array_methods.asp#mark_tostring
::#
:dk_arrayToString () {
	call dk_debugFunc
	if %__ARGC__% neq 2 (call dk_error "%__FUNCTION__%(%__ARGC__%): incorrect number of arguments")

	call dk_set array_name "%~1"

	call dk_arrayLength %~1 array_length
	set /a "count=%array_length%-1"

	setlocal EnableDelayedExpansion
	for /l %%n in (0, 1, %count%) do (
		if "%%n"=="0" (
			set "list=!%array_name%[%%n]!"
		) else (
			set "list=!list!;!%array_name%[%%n]!"
		)
	)

	endlocal & call dk_set %2 "%list%"
goto:eof



:DKTEST ########################################################################

	set "MyArray[0]=1"
	set "MyArray[1]=2"
	set "MyArray[2]=3"
	set "MyArray[3]=a"
	set "MyArray[4]=b"
	set "MyArray[5]=c"
	call dk_arrayToString MyArray MyList
	
	echo MyList = %MyList%