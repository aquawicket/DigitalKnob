@echo off

:setGlobal name value
setlocal enableDelayedExpansion

	echo set "%~1=%~2" > GLOBAL.cmd
	endlocal & set "%~1=%~2"

exit /b 0