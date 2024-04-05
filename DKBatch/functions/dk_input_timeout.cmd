::dk_include_guard()
@echo off
setlocal EnableExtensions EnableDelayedExpansion

::#################################################################################
:: dk_input_timeout(<message> <timeout> <default>)
::
::	reference: https://stackoverflow.com/a/7703584/688352
::
:dk_input_timeout <message> <timeout> <default>
	call dk_verbose "%0(%*)"
	
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
	
	::<nul set /p"=!BS!!CR!%message% (waiting %timeout% seconds) "
	echo "%message% ..user input. will timeout in %timeout% seconds  "
	
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
	::<nul set /p"=!BS!!CR!result = %result%  	"
	set /p"=result = %result% "
goto:eof