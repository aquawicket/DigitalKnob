@echo off
setlocal enableDelayedExpansion
call debugFunc

call dumpStackLine
::set "global=call:getGlobal $"
::echo %global:$=myVar%


::call set_test:main args
::call:main && exit /b 0


:main
setlocal enableDelayedExpansion
	call debugFunc

	call dumpStackLine
	
	call setGlobal myVar main
	
	call funcA A
	
	call dumpvariables

pause
exit /b 0








