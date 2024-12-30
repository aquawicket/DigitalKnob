@echo off
echo ^@echo off > GLOBAL.cmd
if not defined dkcall  set "dkcall=call dkcall"
if not defined lvl (set /a lvl=0)

:main
setlocal enableDelayedExpansion

	call setGlobal "STACK_0" "main"
	
	call setGlobal globalVarA GLOBALA
	call setGlobal globalVarB GLOBALB
	%dkcall% funcA A
	
pause
exit /b 0








