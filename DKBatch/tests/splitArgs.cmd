@echo off

call :splitArgs dk_cmake -G "MinGW Makefiles" -DTEST=1 "-DSTRING=Test string" "-SC:Windows\System32"
call :splitArgs dk_cmakeEval "dk_test('test dk_info message')" "return_valueA;return_valueB"
pause


:splitArgs
setlocal enableDelayedExpansion

	set __ALL__=%*
	if defined __ALL__ (
		set __CMND__=%1
		call set __ARGS__=%%__ALL__:*%1=%%
	)
	
	echo __ALL__  %__ALL__%
	echo __CMND__ %__CMND__%
	echo __ARGS__ %__ARGS__%
exit /b 0



