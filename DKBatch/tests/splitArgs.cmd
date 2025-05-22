@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


call :splitArgs dk_cmake -G "MinGW Makefiles" -DTEST=1 "-DSTRING=Test string" "-SC:Windows/System32"
call :splitArgs dk_cmakeEval "dk_test('test dk_info message')" "return_valueA;return_valueB"
pause


:splitArgs
setlocal enableDelayedExpansion

	set __ALL__=%*
	if defined __ALL__ (
		set __CMND__=%1
		set __ARGS__=!__ALL__:*%1=!
	)
	
	echo __ALL__  %__ALL__%
	echo __CMND__ %__CMND__%
	echo __ARGS__ %__ARGS__%
exit /b 0



