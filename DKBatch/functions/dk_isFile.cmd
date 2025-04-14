@echo off
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%A IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpA")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)

::####################################################################
::# dk_isFile(path rtn_var)
::#
::#
:dk_isFile
setlocal
	%dk_call% dk_debugFunc 1 2
 
    if exist "%~1" if not exist "%~1/*" (
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
	set "myPath=C:/Windows/notepad.exe"
    %dk_call% dk_isFile "%myPath%" result
    if "%result%" equ "true" (%dk_call% dk_info "'%myPath%' is a file") else (%dk_call% dk_info "'%myPath%' is NOT a file")
   
	set "myPath=C:/NotADir"
    %dk_call% dk_isFile "%myPath%" result
    if "%result%" equ "true" (%dk_call% dk_info "'%myPath%' is a file") else (%dk_call% dk_info "'%myPath%' is NOT a file")
    
    ::###### Using if ERRORLEVEL
	set "myPath=C:/Windows"
	%dk_call% dk_isFile "%myPath%"
    if not ERRORLEVEL 1 (%dk_call% dk_info "'%myPath%' is a file") else (%dk_call% dk_info "'%myPath%' is NOT a file")
	
    set "myPath=C:/NotADir"
	%dk_call% dk_isFile "%myPath%"
    if not ERRORLEVEL 1 (%dk_call% dk_info "'%myPath%' is a file") else (%dk_call% dk_info "'%myPath%' is NOT a file")
    
    ::###### Using && and || conditionals
	set "myPath=C:/Windows"
    %dk_call% dk_isFile "%myPath%" && %dk_call% dk_info "'%myPath%' is a file" || %dk_call% dk_info "'%myPath%' is NOT a file"
	
	set "myPath=C:/NotADir"
    %dk_call% dk_isFile "%myPath%" && %dk_call% dk_info "'%myPath%' is a file" || %dk_call% dk_info "'%myPath%' is NOT a file"
%endfunction%
