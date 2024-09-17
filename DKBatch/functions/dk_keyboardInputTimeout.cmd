@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::#################################################################################
::# dk_keyboardInputTimeout(result, default, timeout)
::#
::# reference: https://stackoverflow.com/a/7703584/688352
::#            https://stackoverflow.com/a/33206814/688352
::#
:dk_keyboardInputTimeout <result> <default> <timeout>
    call dk_debugFunc 3
 setlocal
 
    ::set "result=%1"
    set "default=%2"
    set /a "timeout=%3"
    
    set "cache_file=%DKTEMP_DIR%\keyboardInputTimeout_cache.tmp"
    set "thread_file=%DKTEMP_DIR%\keyboardInputTimeout_thread.cmd"
    %dk_call% dk_delete %cache_file% %NO_STD%
    
    echo ^@echo off> %thread_file%
    echo set /p var=>> %thread_file%
    echo ^> %cache_file% echo %%var%%>> %thread_file%
    start /b %ComSpec% /c %thread_file%
    
    set "ESC="
    for /f %%a in ('copy /Z "%~dpf0" nul') do set "ASCII_13=%%a"
    
    :keyboard_input_timeout_loop
    set /a "timeout-=1"
    ::<nul set /p "=.!ASCII_13!     %timeout%" <NUL
    <nul set /p "="<NUL
    %dk_call% dk_setTitle %timeout%

    ping -n 2 localhost %NO_STD%
    if !timeout! GTR 0 (
        %dk_call% dk_setTitle %timeout%
        if not exist %cache_file% goto:keyboard_input_timeout_loop
    )

    :: clear line and console title
    ::<nul set /p "=.!ASCII_13!    %timeout% " <NUL
    %dk_call% dk_setTitle
    
    :keyboard_input_timeout_result
    del %thread_file% %NO_STD%
    if exist %cache_file% (
        set /p result=<%cache_file%
        %dk_call% dk_delete %cache_file% %NO_STD%
    ) else ( 
        set "result=%default%"
    )

    ::echo RESULT=%result%
    endlocal & set "%1=%result%"
%endfunction%







::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
    call dk_debugFunc 0
 setlocal
 
    echo Type some input and press enter, this will time out in 5 seconds
    %dk_call% dk_keyboardInputTimeout 10 "default" rtn_var
    echo result = %rtn_var%
%endfunction%

