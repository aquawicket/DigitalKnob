@echo off
call DK

::################################################################################
::# dk_printArray(<array>)
::#
::#
:dk_printArray () {
	call dk_debugFunc
	if "%~1" equ "" call dk_error "%__FUNCTION__%(%*): argument 1 is invalid"
	if "%~2" neq "" call dk_error "%__FUNCTION__%(%*): too many arguments"
	
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
