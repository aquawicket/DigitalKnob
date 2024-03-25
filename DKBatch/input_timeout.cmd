:: https://stackoverflow.com/a/7703584/688352

@echo off
setlocal EnableDelayedExpansion
::### keep window open ###
if not defined in_subprocess (cmd /k set in_subprocess=y ^& %0 %*) & exit )

:: https://superuser.com/a/1166728
for /f %%a in ('copy /Z "%~dpf0" nul') do set "CR=%%a"
for /f %%a in ('"prompt $H&for %%b in (0) do rem"') do set "BS=%%a"
	
	



::main()
:main
	call:input_timeout "My Message" 5 "no selection"
goto:eof



::input_timeout(<message> <timeout> <default>)
:input_timeout
	::%DKDEBUGFUNC% %0 %*
	set "message=%1"
	set /a timeout=%2
	set "default=%3"
	del input_timeout.tmp 2>nul >nul
	::start /b cmd /c %SOURCE_PATH% goto:input_timeout_inputThread
	
	echo ^@echo off> input_timeout_thread.cmd
	echo set /p var=>> input_timeout_thread.cmd
	echo ^> input_timeout.tmp echo %%var%%>> input_timeout_thread.cmd
	start /b cmd /c input_timeout_thread.cmd
	
	set n=0
	
	<nul set /p"=%message% (waiting %timeout% seconds)"
	
	:input_timeout_loop
	::echo :input_timeout_loop
	::TITLE !timeout!
	set /a timeout-=1
	ping -n 2 localhost > nul
	if !timeout! GTR 0 (
		<nul set /p"=!BS!!CR!%message% (waiting %timeout% seconds)"
		if not exist input_timeout.tmp goto :input_timeout_loop
	)
		
	:input_timeout_result
	::echo :input_timeout_result
	del input_timeout_thread.cmd 2>nul >nul
	if exist input_timeout.tmp (
		set /p result=<input_timeout.tmp
	) else (
		set result=%default%
	)
	::echo result = %result%
	<nul set /p"=!BS!!CR!result = %result%                 "
	::TITLE %result%
goto:eof
