@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd"

::#################################################################################
::# dk_keyboardInputTimeout(input, timeout, default, result)
::#
::#	reference: https://stackoverflow.com/a/7703584/688352
::#
:dk_keyboardInputTimeout <input> <timeout> <default> <result>
	call dk_debugFunc 4
	
	setlocal EnableExtensions EnableDelayedExpansion
	set "message=%1"
	set /a timeout=%2
	set "default=%3"
	
	set cache_file=%DKTEMP_DIR%\keyboardInputTimeout_cache.tmp
	set thread_file=%DKTEMP_DIR%\keyboardInputTimeout_thread.cmd
	%dk_call% dk_delete %cache_file% %NO_STD%
	
	echo ^@echo off> %thread_file%
	echo set /p var=>> %thread_file%
	echo ^> %cache_file% echo %%var%%>> %thread_file%
	start /b %ComSpec% /c %thread_file%
	
	setlocal enableextensions enabledelayedexpansion
	for /f %%a in ('copy /Z "%~dpf0" nul') do set "ASCII_13=%%a"
	
	:keyboard_input_timeout_loop
	set /a timeout-=1
	<nul set /p "=.!ASCII_13!     %timeout% " <NUL
	%dk_call% dk_setTitle %timeout%

	ping -n 2 localhost %NO_STD%
	if !timeout! GTR 0 (
		%dk_call% dk_setTitle %timeout%
		if not exist %cache_file% goto:keyboard_input_timeout_loop
	)
	
	
	<nul set /p "=.!ASCII_13!      " <NUL
	%dk_call% dk_setTitle
	
	:keyboard_input_timeout_result
	del %thread_file% %NO_STD%
	if exist %cache_file% (
		set /p result=<%cache_file%
		%dk_call% dk_delete %cache_file% %NO_STD%
	) else ( 
		set result=%default% 
	)

	echo RESULT=%result%
	if "%~4" neq "" endlocal & set "%4=%result%"
goto:eof







::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc 0
	
	echo DKTEST_BEGIN
	%dk_call% dk_keyboardInputTimeout "this message will time out" 3 default rtn_var
	echo returned_result = %rtn_var%
	echo DKTEST_END
goto:eof

