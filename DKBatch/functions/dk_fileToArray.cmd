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
	if %__ARGC__% NEQ 2 (call dk_error "%__FUNCTION__%(%__ARGC__%): incorrect number of arguments")
	
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



:DKTEST ########################################################################
