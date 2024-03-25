:: https://stackoverflow.com/a/7703584/688352

@echo off
setlocal EnableExtensions EnableDelayedExpansion
::### keep window open ###
if not defined in_subprocess (cmd /k set in_subprocess=y ^& %0 %*) & exit )

:: https://superuser.com/a/1166728
for /f %%a in ('copy /Z "%~dpf0" nul') do set "CR=%%a"
for /f %%a in ('"prompt $H&for %%b in (0) do rem"') do set "BS=%%a"
	


::main()
:main
	call:input_timeout "My Message" "10" "no selection"
goto:eof



::input_timeout(<message> <timeout> <default>)
:input_timeout
	set "message=%1"
	set /a timeout=%2
	set "default=%3"
	set cache_file=%~dp0input_timeout_cache.tmp
	set thread_file=%~dp0input_timeout_thread.cmd
	del %cache_file% 2>nul >nul
	
	echo ^@echo off> %thread_file%
	echo set /p var=>> %thread_file%
	echo ^> %cache_file% echo %%var%%>> %thread_file%
	start /b cmd /c %thread_file%
	
	<nul set /p"=!BS!!CR!%message% (waiting %timeout% seconds) "
	
	:input_timeout_loop
	set /a timeout-=1
	::<nul set /p"=!BS!!CR!%message% (waiting %timeout% seconds) "
	
	ping -n 2 localhost > nul
	if !timeout! GTR 0 (
		TITLE %timeout%
		if not exist %cache_file% goto :input_timeout_loop
	)
		
	:input_timeout_result
	del %thread_file% 2>nul >nul
	if exist %cache_file% (
		set /p result=<%cache_file%
		del %cache_file% 2>nul >nul
	) else (
		set result=%default%
	)
	<nul set /p"=!BS!!CR!result = %result%                 "
goto:eof
