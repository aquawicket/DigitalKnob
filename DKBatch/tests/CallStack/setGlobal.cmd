@echo off

:setGlobal name value
setlocal enableDelayedExpansion

	::echo set "%~1=%~2" >> GLOBAL.cmd
	::echo %~1 >> GLOBAL.cmd
	
	:: prefix the variable name with GLOBAL_ and assign a value
	set "GLOBAL_%~1=%~2"
	
	:: place all vairable with a GLOBAL_ prefix into GLOBAL.txt
	set GLOBAL_ > GLOBAL.txt

	endlocal & set "%~1=%~2"
exit /b 0