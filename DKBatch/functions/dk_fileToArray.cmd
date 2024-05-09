@echo off
call DK

::################################################################################
::# dk_fileToArray(<path> <output>)
::#
::#  Read lines of a file into an array and echo them back
::#
::#  reference: https://stackoverflow.com/a/49042678
::#
:dk_fileToArray () {
	call dk_debugFunc
	if "%~1" equ "" call dk_error "%__FUNCTION__%(%*): argument 1 is invalid"
	if "%~2" equ "" call dk_error "%__FUNCTION__%(%*): argument 2 is invalid"
	if "%~3" neq "" call dk_error "%__FUNCTION__%(%*): too many arguments"
	
    ::set "file=%~1"
	set /A i=0
	setlocal EnableDelayedExpansion
    for /F "usebackq delims=" %%a in ("%~1") do (
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