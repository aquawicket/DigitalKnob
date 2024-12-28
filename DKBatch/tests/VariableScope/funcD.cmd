@echo off

:: The label name has no effect if not call from within the file, I.E. :DifferentName
::call :DifferentName


:DifferentName
setlocal enableDelayedExpansion
	call debugFunc

	call dumpStackLine
	
	call setGlobal myVar reverse
	::call funcE E
	
	call dumpvariables
	
exit /b 0