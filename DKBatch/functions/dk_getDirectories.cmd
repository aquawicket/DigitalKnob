@echo off
call DK

::################################################################################
::# dk_getDirectories(<path> <output>)
::#
::#   reference: https://stackoverflow.com/a/138581
::#
:dk_getDirectories () {
	call dk_debugFunc
	if "%~1" equ "" call dk_error "%__FUNCTION__%(%*): argument 1 is invalid"
	if "%~2" equ "" call dk_error "%__FUNCTION__%(%*): argument 2 is invalid"
	if "%~3" neq "" call dk_error "%__FUNCTION__%(%*): too many arguments"
	
	::set "path=%~1"
	::set "folders="
	set /A i=0
	setlocal enabledelayedexpansion
	for /d %%a in ("%~1\*") do ( 
		set "%~2[!i!]=%%a"
		set /A i+=1
	) 

	:: Return the array to the calling scope
	set "currentScope=1"
	for /F "delims=" %%a in ('set %~2[') do (
	   if defined currentScope endlocal
	   set "%%a"
	)
goto:eof




:DKTEST ########################################################################

	call dk_getDirectories "C:\Windows" result
	call dk_printVar result
	