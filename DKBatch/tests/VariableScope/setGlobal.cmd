@echo off

:setGlobal name value
setlocal enableDelayedExpansion

	echo %~2 > %~1.var
	endlocal & set "%~1=%~2"

exit /b 0