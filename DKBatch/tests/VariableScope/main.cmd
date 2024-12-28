@echo off
set "dkcall=call dkcall"
if not defined lvl (set /a lvl=0)


setlocal enableDelayedExpansion
call setGlobal myVar main
call dumpvariables

:main
setlocal enableDelayedExpansion
	call dumpvariables
	%dkcall% funcA A
	call dumpvariables
pause
exit /b 0








