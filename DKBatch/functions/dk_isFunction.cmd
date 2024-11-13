@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::##############################################################################
::# dk_isFunction(name) -> rtn_var
::# 
::# Test if a string is a function name
::#
::# @name   - The name to test
::# @rtn_var:   - True if the string is the name of a function, False if otherwise.
::#
::# https://stackoverflow.com/a/85932/688352
::#
:dk_isFunction
    call dk_debugFunc 1
 setlocal
 
    %ComSpec% /c "(help %~1 > nul || exit 0) && where %~1 > nul 2> nul"
    if %ERRORLEVEL% equ 0 (
        if "%~2" neq "" (endlocal & set "%2=true")
        exit /b 0
    )
    
    if "%~2" neq "" (endlocal & set "%2=false")
    exit /b 1
%endfunction%









::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
    call dk_debugFunc 0
 setlocal
    
    %dk_call% dk_isFunction "dk_debugFunc" && %dk_call% dk_info "'dk_debugFunc' is a function" || %dk_call% dk_info "'dk_debugFunc' is NOT a function"
    %dk_call% dk_isFunction "NotAFunction" && %dk_call% dk_info "'NotAFunction' is a function" || %dk_call% dk_info "'NotAFunction' is NOT a function"
%endfunction%
