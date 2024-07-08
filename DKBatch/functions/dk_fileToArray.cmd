@echo off
call %DKBATCH_FUNCTIONS_DIR_%DK.cmd

::################################################################################
::# dk_fileToArray(path rtn_var)
::#
::#  Read lines of a file into an array and echo them back
::#
::#  reference: https://stackoverflow.com/a/49042678
::#
:dk_fileToArray
	call dk_debugFunc
	if %__ARGC__% neq 2 call dk_error "%__FUNCTION__%:%__ARGV__% incorrect number of arguments"
	
	setlocal EnableDelayedExpansion
    ::set "file=%~1"
	set /a i=0
    for /F "usebackq delims=" %%a in ("%~f1") do (
		set "%~2[!i!]=%%a"
		set /a i+=1
    )
	
	:: Return the array to the calling scope
	set "currentScope=1"
	for /F "delims=" %%a in ('set %~2[') do (
	   if defined currentScope endlocal
	   set "%%a"
	)
goto:eof






::####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ######
:DKTEST
	call dk_debugFunc

	:: create the file
	dir /b /a-d > array.cmd

	call dk_fileToArray "array.cmd" MyArray
	::call dk_arrayLength MyArray MyArrayLength
	::echo MyArrayLength = %MyArrayLength%
	call dk_printArray MyArray

	:: or print items individually

	echo MyArray[0] = %MyArray[0]%
	echo MyArray[1] = %MyArray[1]%
	echo MyArray[2] = %MyArray[2]%
goto:eof

