@echo off
call %DKBATCH_FUNCTIONS_DIR_%DK.cmd

::################################################################################
::# dk_listToArray(<list> rtn_var)
::#
::#
:dk_listToArray
	call dk_debugFunc
	if %__ARGC__% neq 2 call dk_error "%__FUNCTION__%:%__ARGV__% incorrect number of arguments"
	
	setlocal EnableDelayedExpansion
	set _list=%~1
	if defined !_list! set _list=!%_list%!

	set /A i=0
	for %%a in (!_list!) do (
		set "%~2[!i!]=%%a"
		set /A i+=1
	) 
	
	rem Return the array to the calling scope
	set "currentScope=1"
	for /F "delims=" %%a in ('set %~2[') do (
	   if defined currentScope endlocal
	   set "%%a"
	)
goto:eof





::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc

	call dk_todo
	call dk_listToArray
goto:eof
