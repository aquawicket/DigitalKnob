@echo off
if not defined DK_CMD (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*)

::####################################################################
::# dk_isDirectory(path rtn_var)
::#
::#
:dk_isDirectory
setlocal
	%dk_call% dk_debugFunc 1 2
 
    if exist "%~1/*" (
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
   
    ::###### Using if return value
	set "myPath=C:/Windows"
    %dk_call% dk_isDirectory "%myPath%" result
    if "%result%" equ "true" (%dk_call% dk_info "'%myPath%' is a directory") else (%dk_call% dk_info "'%myPath%' is NOT a directory")
   
	set "myPath=C:/NotADir"
    %dk_call% dk_isDirectory "%myPath%" result
    if "%result%" equ "true" (%dk_call% dk_info "'%myPath%' is a directory") else (%dk_call% dk_info "'%myPath%' is NOT a directory")
    
    ::###### Using if ERRORLEVEL
	set "myPath=C:/Windows"
	%dk_call% dk_isDirectory "%myPath%"
    if not ERRORLEVEL 1 (%dk_call% dk_info "'%myPath%' is a directory") else (%dk_call% dk_info "'%myPath%' is NOT a directory")
	
    set "myPath=C:/NotADir"
	%dk_call% dk_isDirectory "%myPath%"
    if not ERRORLEVEL 1 (%dk_call% dk_info "'%myPath%' is a directory") else (%dk_call% dk_info "'%myPath%' is NOT a directory")
    
    ::###### Using && and || conditionals
	set "myPath=C:/Windows"
    %dk_call% dk_isDirectory "%myPath%" && %dk_call% dk_info "'%myPath%' is a directory" || %dk_call% dk_info "'%myPath%' is NOT a directory"
	
	set "myPath=C:/NotADir"
    %dk_call% dk_isDirectory "%myPath%" && %dk_call% dk_info "'%myPath%' is a directory" || %dk_call% dk_info "'%myPath%' is NOT a directory"
%endfunction%
