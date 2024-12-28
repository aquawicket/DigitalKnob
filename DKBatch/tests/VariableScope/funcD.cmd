@echo off

:: The label name has no effect if not call from within the file, I.E. :DifferentName
::call :DifferentName


:DifferentName
setlocal enableDelayedExpansion
	call dumpvariables
	call setGlobal myVar reverse
	echo:
	call dumpvariables
exit /b 0