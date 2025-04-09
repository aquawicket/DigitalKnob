@echo off
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%A IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpA")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)

::##############################################################################
::# dk_haveInternet(name) -> rtn_bool
::# 
::#
:dk_haveInternet
setlocal
    %dk_call% dk_debugFunc 0 1

 
    %COMSPEC% /c ping -n 1 8.8.8.8 > nul 2> nul"
    if %ERRORLEVEL% equ 0 (
        if "%~2" neq "" (endlocal & set "%2=true")
        exit /b 0
    )
    
    if "%~2" neq "" (endlocal & set "%2=false")
    exit /b 1
%endfunction%









::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0
   
    %dk_call% dk_haveInternet && %dk_call% dk_echo "Connected" || %dk_call% dk_echo "Dissconected"
%endfunction%
