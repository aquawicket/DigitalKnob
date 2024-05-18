@echo off
call DK

::################################################################################
::# dk_getFiles(<path> <output>)
::#
::#   reference: https://stackoverflow.com/a/138581
::#
:dk_getFiles () {
	call dk_debugFunc
	if %__ARGC__% NEQ 2 (call dk_error "%__FUNCTION__%(): incorrect number of arguments")
	::set "path=%~1"
	
	set /a i=0
	setlocal enabledelayedexpansion
	for %%a in ("%~1\*") do ( 
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
