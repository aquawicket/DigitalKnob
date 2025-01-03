@echo off

:: The label name has no effect if not call from within the file, I.E. :DifferentName
::call :DifferentName


:funcD
setlocal enableDelayedExpansion
	
	set "LOCAL_VAR=local D"
	%dk_call% :PrintCallStack

exit /b 0