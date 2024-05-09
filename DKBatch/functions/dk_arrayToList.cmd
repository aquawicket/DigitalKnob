@echo off
call DK

::################################################################################
::# dk_arrayToList(<array_name> <output>)
::#
::#
:dk_arrayToList () {
	call dk_debugFunc
	if "%~1" equ "" call dk_error "%__FUNCTION__%(%*): argument 1 is invalid"
	if "%~2" equ "" call dk_error "%__FUNCTION__%(%*): argument 2 is invalid"
	if "%~3" neq "" call dk_error "%__FUNCTION__%(%*): too many arguments"

	set "array_name=%~1"
	::call dk_printVar array_name

	call dk_getArrayLength %~1 array_length
	set /a "count=%array_length%-1"

	setlocal EnableDelayedExpansion
	for /l %%n in (0, 1, %count%) do (
		if "%%n"=="0" (
			set "list=!%array_name%[%%n]!"
		) else (
			set "list=!list!;!%array_name%[%%n]!"
		)
	)

	endlocal & set "%2=%list%" 
goto:eof



:DKTEST ########################################################################

	set "MyArray[0]=1"
	set "MyArray[1]=2"
	set "MyArray[2]=3"
	set "MyArray[3]=a"
	set "MyArray[4]=b"
	set "MyArray[5]=c"
	call dk_arrayToList MyArray MyList
	
	call dk_printVar MyList