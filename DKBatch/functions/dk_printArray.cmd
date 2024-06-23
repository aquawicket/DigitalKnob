@echo off
call DK.cmd

::################################################################################
::# dk_printArray(array)
::#
::#
:dk_printArray () {
	call dk_debugFunc
	if %__ARGC__% neq 1 (call dk_error "%__FUNCTION__%(%__ARGC__%): incorrect number of arguments")
	
	set "arry=%~1"
	set /A "n=0"
	setlocal EnableDelayedExpansion
		:loop1
		if defined %arry%[%n%] ( 
		   call dk_info "%arry%[%n%] = !%arry%[%n%]!"
		   set /A n+=1
		   goto :loop1 
		)
		call dk_info "%arry% length = %n%"
	endlocal
goto:eof
