@echo off

:setGlobal name value
::setlocal enableDelayedExpansion

	::echo set "%~1=%~2" >> GLOBAL.cmd
	::echo %~1 >> GLOBAL.cmd
	set "%~1=%~2"
	
	:: prefix the variable name with GLOBAL_ and assign a value
	set "GLOBAL_%~1=%~2"
	
	:: place all vairable with a GLOBAL_ prefix into %GLOBAL_FILE%
	set GLOBAL_ > "%GLOBAL_FILE%"

	
exit /b 0