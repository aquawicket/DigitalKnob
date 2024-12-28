@echo off


:main
setlocal enableDelayedExpansion
	
	
	call setGlobal globalVar GLOBAL
	call dkcall funcA A
	



pause
exit /b 0








