@echo off


:main
setlocal enableDelayedExpansion
	call printStack
	
	call setGlobal globalVarA GLOBALA
	call setGlobal globalVarB GLOBALB
	call dkcall funcA A
	
	call printStack
pause
exit /b 0








