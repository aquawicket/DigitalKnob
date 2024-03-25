@echo off
setlocal EnableDelayedExpansion
::### keep window open ###
if not defined in_subprocess (cmd /k set in_subprocess=y ^& %0 %*) & exit )


:::: INPUT_TIMEOUT ::::
:input_timeout
	set DEADLINE=10
	set /a countdown=%DEADLINE%
	if "%1" NEQ "" goto %1
	::-------------------------------------------------------> call secondThread

	del input_timeout.tmp 2>nul >nul
	start /b cmd /c %0 :input_timeout_secondThread
	::-------------------------------------------------------> start secondThread
	set n=0
	echo Enter Text (%DEADLINE% second timeout):

	:input_timeout_loop
	::echo :input_timeout_loop
	set /a second+=1
	TITLE !countdown!
	set /a countdown-=1
	ping -n 2 localhost > nul
	if !second! LSS %DEADLINE% (
		TITLE !countdown!
		if not exist input_timeout.tmp goto :input_timeout_loop
		< input_timeout.tmp (
			set /p input=
		)
		set result=!input!
		goto input_timeout_result
	   
	) ELSE (
		set result=default
		goto input_timeout_result
	)
	goto:eof
	
	:input_timeout_secondThread
		::echo :input_timeout_secondThread
		set /p var=
		> input_timeout.tmp echo !var!
	goto:eof

	:input_timeout_result
		::echo.
		::echo :input_timeout_result
		echo result = %result%
		TITLE %result%
	goto:eof
goto:eof
