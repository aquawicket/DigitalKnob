@echo off
call %DKBATCH_FUNCTIONS_DIR_%DK.cmd

call dk_source dk_setTitle
::#################################################################################
::# dk_inputTimeout(message, timeout, default)
::#
::#	reference: https://stackoverflow.com/a/7703584/688352
::#
:dk_inputTimeout <message> <timeout> <default>
	call dk_debugFunc
	if %__ARGC__% neq 3 call dk_error "%__FUNCTION__%:%__ARGV__% incorrect number of arguments"
	
	setlocal EnableExtensions EnableDelayedExpansion
	set "message=%1"
	set /a timeout=%2
	set "default=%3"
	set cache_file=%~dp0input_timeout_cache.tmp
	set thread_file=%~dp0input_timeout_thread.cmd
	call dk_remove %cache_file% 2>nul >nul
	
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
		call dk_setTitle %timeout%
		if not exist %cache_file% goto :input_timeout_loop
	)
		
	:input_timeout_result
	del %thread_file% 2>nul >nul
	if exist %cache_file% (
		set /p result=<%cache_file%
		call dk_remove %cache_file% 2>nul >nul
	) else (
		set result=%default%
	)
	::<nul set /p"=!BS!!CR!result = %result%  	"
	set /p"=result = %result% "
goto:eof







::####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST #######
:DKTEST
	call dk_debugFunc
	
	call dk_inputTimeout "this message will time out" 5 default
goto:eof

