@echo off
call %DKBATCH_FUNCTIONS_DIR_%DK.cmd

::################################################################################
::# dk_getDirectories(path rtn_var)
::#
::#   reference: https://stackoverflow.com/a/138581
::#
:dk_getDirectories
	call dk_debugFunc
	if %__ARGC__% neq 2 (call dk_error "%__FUNCTION__%(%__ARGC__%): incorrect number of arguments")
	
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




:DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###

	call dk_getDirectories "C:\Windows" result
	call dk_printVar result
	