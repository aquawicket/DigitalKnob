@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::##############################################################################
::# dk_haveInternet(name) -> rtn_bool
::# 
::#
:dk_haveInternet
    call dk_debugFunc 0 1
 setlocal
 
    %ComSpec% /c ping -n 1 8.8.8.8 > nul 2> nul"
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
    
    %dk_call% dk_haveInternet && %dk_call% dk_echo "Connected" || %dk_call% dk_echo "Dissconected"
%endfunction%
