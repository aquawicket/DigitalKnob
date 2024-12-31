@echo off


call dkcall :init

:main
setlocal enableDelayedExpansion

	call setGlobal "STACK_0" "main"
	
	call setGlobal globalVarA GLOBALA
	call setGlobal globalVarB GLOBALB
	%dkcall% funcA A
	
pause
exit /b 0








