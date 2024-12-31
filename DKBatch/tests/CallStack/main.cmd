@echo off
setlocal enableDelayedExpansion

call dkcall %0
:main


	%dkcall% setGlobal globalVarA GLOBALA
	%dkcall% setGlobal globalVarB GLOBALB
	%dkcall% funcA A
	
pause
exit /b 0








