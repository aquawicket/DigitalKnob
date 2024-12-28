@echo off

:getGlobal name
setlocal enableDelayedExpansion

	set /p value=< %~1.var
	endlocal & set "%~1=%value%"
	
exit /b 0