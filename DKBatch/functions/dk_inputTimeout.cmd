@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd"

::#################################################################################
::# dk_inputTimeout(message, timeout, default)
::#
::#	reference: https://stackoverflow.com/a/7703584/688352
::#
:dk_inputTimeout <message> <timeout> <default>
	call dk_debugFunc 3
	
	setlocal EnableExtensions EnableDelayedExpansion
	set "message=%1"
	set /a timeout=%2
	set "default=%3"
	
	set cache_file=%DKTEMP_DIR%\input_timeout_cache.tmp
	set thread_file=%DKTEMP_DIR%\input_timeout_thread.cmd
	%dk_call% dk_delete %cache_file% %NO_STD%
	
	echo ^@echo off> %thread_file%
	echo set /p var=>> %thread_file%
	echo ^> %cache_file% echo %%var%%>> %thread_file%
	start /b %ComSpec% /c %thread_file%
	
	setlocal enableextensions enabledelayedexpansion
	for /f %%a in ('copy /Z "%~dpf0" nul') do set "ASCII_13=%%a"
	
	:input_timeout_loop
	set /a timeout-=1
	<nul set /p "=.!ASCII_13!     %timeout% " <NUL

	ping -n 2 localhost %NO_STD%
	if !timeout! GTR 0 (
		%dk_call% dk_setTitle %timeout%
		if not exist %cache_file% goto :input_timeout_loop
	)
		
	:input_timeout_result
	del %thread_file% %NO_STD%
	if exist %cache_file% (
		set /p result=<%cache_file%
		%dk_call% dk_delete %cache_file% %NO_STD%
	) else ( set result=%default% )

	echo RESULT=%result%
goto:eof







::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc 0
	
	echo DKTEST_BEGIN
	%dk_call% dk_inputTimeout "this message will time out" 3 default
	echo DKTEST_END
	
goto:eof

