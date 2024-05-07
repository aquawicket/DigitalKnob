@echo off
call DK

::################################################################################
::# dk_printArray(<array>)
::#
::#
:dk_printArray () {

	set "arry=%~1"
	set /A "n=0"
	
	setlocal EnableDelayedExpansion
	:loop1
	if defined %arry%[%n%] ( 
	   echo %arry%[%n%] = !%arry%[%n%]!
	   set /A n+=1
	   goto :loop1 
	)
	echo %arry% length = %n%
	endlocal
goto:eof
