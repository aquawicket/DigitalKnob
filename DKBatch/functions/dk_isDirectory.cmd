<<<<<<< HEAD
@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*
=======
@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::#################################################################################################################################################

>>>>>>> Development

::####################################################################
::# dk_isDirectory(path rtn_var)
::#
::#
:dk_isDirectory
<<<<<<< HEAD
    call dk_debugFunc 1 2
 setlocal
 
    if exist %~1\* (
=======
setlocal
	%dk_call% dk_debugFunc 1 2
 
    if exist "%~1/*" (
>>>>>>> Development
        if "%~2" neq "" (endlocal & set "%2=true")
        exit /b 0
    )
    
    if "%~2" neq "" (endlocal & set "%2=false")
    exit /b 1
%endfunction%







::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
<<<<<<< HEAD
    call dk_debugFunc 0
 setlocal
    
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
=======
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
>>>>>>> Development
%endfunction%
