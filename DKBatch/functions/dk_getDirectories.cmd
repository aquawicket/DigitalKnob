@echo off
call DK

::################################################################################
::# dk_getDirectories(<path> <output>)
::#
::#   reference: https://stackoverflow.com/a/138581
::#
:dk_getDirectories () {
	call dk_debugFunc
	if %__ARGC__% NEQ 2 (dk_error "%__FUNCTION__%(): incorrect number of arguments")
	
	call dk_replaceAll "%~1" "/" "\" _path_
	::set "folders="
	set /A i=0
	setlocal enabledelayedexpansion
	for /d %%a in ("%_path_%\*") do ( 
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
	