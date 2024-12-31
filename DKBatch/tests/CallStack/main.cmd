@echo off
call dkcall

:main
setlocal enableDelayedExpansion

	call setGlobal globalVarA GLOBALA
	call setGlobal globalVarB GLOBALB
	%dkcall% funcA A
	
pause
exit /b 0








