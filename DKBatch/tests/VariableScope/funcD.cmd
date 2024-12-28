@echo off

:: The label name has no effect if not call from within the file, I.E. :DifferentName
::call :DifferentName


:DifferentName
setlocal enableDelayedExpansion

	call setGlobal globalVar "STILL GLOBAL"

exit /b 0