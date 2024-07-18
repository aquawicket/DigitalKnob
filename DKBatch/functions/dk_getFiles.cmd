@echo off
call %DKBATCH_FUNCTIONS_DIR_%DK.cmd

::################################################################################
::# dk_getFiles(path rtn_var)
::#
::#   reference: https://stackoverflow.com/a/138581
::#
:dk_getFiles
	call dk_debugFunc
	if %__ARGC__% neq 2 call dk_error "%__FUNCTION__%:%__ARGV__% incorrect number of arguments"
	::set "path=%~1"
	
	set /a i=0
	setlocal enabledelayedexpansion
	for %%a in ("%~1\*") do (
		%if_DE% set "%~2[!i!]=%%a"
		%if_NDE% call set "%~2[%%i%%]=%%a"
		set /A i+=1
	) 

	:: Return the array to the calling scope
	set "currentScope=1"
	for /F "delims=" %%a in ('set %~2[') do (
	   if defined currentScope endlocal
	   set "%%a"
	)
goto:eof







::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc
	
	call dk_set myPath "C:\Windows"
	call dk_getFiles "%myPath%" files
	call dk_printVar files
goto:eof
