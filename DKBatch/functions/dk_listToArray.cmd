@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd"

::################################################################################
::# dk_listToArray(<list> rtn_var)
::#
::#
:dk_listToArray
	call dk_debugFunc 2
	
	setlocal
	set "_list=%~1"
	if "!!" neq "" if defined %_list% call set _list=%%_list%%
	if "!!" equ "" if defined !_list! set _list=!%_list%!

	set /A i=0
	for %%a in (%_list%) do (
		if "!!" neq "" call set "%~2[%%i%%]=%%a"
		if "!!" equ "" set "%~2[!i!]=%%a"
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
	call dk_debugFunc 0

	call dk_set myList "a,b,c,d,e,f,g"
	call dk_listToArray "%myList%" myArray
	call dk_printVar myArray
goto:eof
