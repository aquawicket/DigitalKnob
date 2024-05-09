@echo off
call DK

::################################################################################
::# dk_getDirectories(<path> <output>)
::#
::#   reference: https://stackoverflow.com/a/138581
::#
:dk_getDirectories () {
	call dk_debugFunc
	
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
	::echo result[0] = %result[0]%
	