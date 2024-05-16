@echo off
call DK

::################################################################################
::# dk_printArray(<array>)
::#
::#
:dk_printArray () {
	call dk_debugFunc
	if %__ARGC__% NEQ 1 (dk_error "%__FUNCTION__%(): incorrect number of arguments")
	
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
