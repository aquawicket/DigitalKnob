@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*

::####################################################################
::# dk_isDirectory(path rtn_var)
::#
::#
:dk_isDirectory
 setlocal
    call dk_debugFunc 1 2
    
    if exist %~1\* (
        if "%~2" neq "" (endlocal & set "%2=true")
        exit /b 0
    )
    
    if "%~2" neq "" (endlocal & set "%2=false")
    exit /b 1
%endfunction%







::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
 setlocal
    call dk_debugFunc 0
    
    ::###### Using if return value
    %dk_call% dk_isDirectory "C:\Windows" result
    if "%result%" equ "true" (%dk_call% dk_info "'C:\Windows' is a directory") else (%dk_call% dk_info "'C:\Windows' is NOT a directory")
    %dk_call% dk_isDirectory "C:\NotADir" result
    if "%result%" equ "true" (%dk_call% dk_info "'C:\Windows' is a directory") else (%dk_call% dk_info "'C:\Windows' is NOT a directory")
    
    ::###### Using if ERRORLEVEL
    %dk_call% dk_isDirectory "C:\Windows"
    if not ERRORLEVEL 1 (%dk_call% dk_info "'C:\Windows' is a directory") else (%dk_call% dk_info "'C:\Windows' is NOT a directory")
    %dk_call% dk_isDirectory "C:\NotADir"
    if not ERRORLEVEL 1 (%dk_call% dk_info "'C:\Windows' is a directory") else (%dk_call% dk_info "'C:\Windows' is NOT a directory")
    
    ::###### Using && and || conditionals
    %dk_call% dk_isDirectory "C:\Windows" && %dk_call% dk_info "'C:\Windows' is a directory" || %dk_call% dk_info "'C:\Windows' is NOT a directory"
    %dk_call% dk_isDirectory "C:\NotADir" && %dk_call% dk_info "'C:\NotADir' is a directory" || %dk_call% dk_info "'C:\NotADir' is NOT a directory"
%endfunction%
