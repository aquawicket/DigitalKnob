@echo off

:: The label name has no effect if not call from within the file, I.E. :DifferentName
::call :DifferentName


:funcD
setlocal enableDelayedExpansion
	::call printStack
	
	set "LOCAL_VAR=local D"
	call setGlobal globalVarA "STILL A GLOBAL"
	
	::call printStack
exit /b 0