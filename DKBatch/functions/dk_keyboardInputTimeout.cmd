@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::#################################################################################################################################################


::#################################################################################
::# dk_keyboardInputTimeout(<default>, <timeout>, <ret>:OPTIONAL)
::#
::# reference: https://stackoverflow.com/a/7703584/688352
::#            https://stackoverflow.com/a/33206814/688352
::#
:dk_keyboardInputTimeout
%setlocal%
	%dk_call% dk_debugFunc 0 3
    
    set "default=%~1"
    set /a "timeout=%~2"
    
    set "cache_file=%DKCACHE_DIR%/keyboardInputTimeout_cache.tmp"
    set "thread_file=%DKCACHE_DIR%/keyboardInputTimeout_thread.cmd"
    %dk_call% dk_delete %cache_file% %NO_OUTPUT%
    
    echo ^@echo off> %thread_file%
    echo set /p var=>> %thread_file%
    echo ^> %cache_file% echo %%var%%>> %thread_file%
    start /b %ComSpec% /c %thread_file%
    
    set "ESC="
    for /f %%a in ('copy /Z "%~dpf0" nul') do set "ASCII_13=%%a"
    
    :keyboard_input_timeout_loop
		set /a "timeout-=1"
		%dk_call% dk_title %timeout%
		::<nul set /p "=.!ASCII_13!     %timeout%" <NUL
		::<nul set /p "="<NUL

		ping -n 2 localhost %NO_OUTPUT%
		if !timeout! GTR 0 (
			if not exist %cache_file% goto keyboard_input_timeout_loop
		)
    
    :keyboard_input_timeout_result
    del %thread_file% %NO_OUTPUT%
    if exist %cache_file% (
        set /p dk_keyboardInputTimeout=<%cache_file%
        %dk_call% dk_delete %cache_file% %NO_OUTPUT%
    ) else ( 
        set "dk_keyboardInputTimeout=%default%"
    )

    endlocal & (
		set "dk_keyboardInputTimeout=%dk_keyboardInputTimeout%"
		if "%~3" neq "" (set "%~3=%dk_keyboardInputTimeout%")
	)
%endfunction%







::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0

    %dk_call% dk_echo "Type some input and press enter, this will time out in 10 seconds"
    %dk_call% dk_keyboardInputTimeout "default" 10
    %dk_call% dk_printVar dk_keyboardInputTimeout
%endfunction%

