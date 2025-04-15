@echo off
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%A IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpA")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)

::####################################################################
::# dk_isDirectory(path rtn_var)
::#
::#
:dk_isDirectory
setlocal
	%dk_call% dk_debugFunc 1 2
 
	%dk_call% dk_assertPath "%~1"
	
	if not exist "%~1" (
		set "dk_isDirectory=-1"
		exit /b %dk_isDirectory%
	)
	
	if exist "%~1/*" (
		set "dk_isDirectory=0"
	) else (
		set "dk_isDirectory=1"
	)
	
    endlocal & (
		set "dk_isDirectory=%dk_isDirectory%"
		if "%~2" neq "" (set "%~2=%dk_isDirectory%")
		exit /b %dk_isDirectory%
	)
%endfunction%







::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0
   
	::############ C:/Windows/notepad.exe ############
    ::###### Using if return value
	set "myPath=C:/Windows/notepad.exe"
    %dk_call% dk_isDirectory "%myPath%"
    if %dk_isDirectory% equ 0 (%dk_call% dk_info "'%myPath%' is a directory") else (%dk_call% dk_info "'%myPath%' is NOT a directory")
	::###### Using if ERRORLEVEL
	%dk_call% dk_isDirectory "%myPath%"
    if not ERRORLEVEL 1 (%dk_call% dk_info "'%myPath%' is a directory") else (%dk_call% dk_info "'%myPath%' is NOT a directory")
    ::###### Using && and || conditionals
    %dk_call% dk_isDirectory "%myPath%" && %dk_call% dk_info "'%myPath%' is a directory" || %dk_call% dk_info "'%myPath%' is NOT a directory"
	
	::############ C:/Windows ############
	::###### Using if return value
	set "myPath=C:/Windows"
    %dk_call% dk_isDirectory "%myPath%"
    if %dk_isDirectory% equ 0 (%dk_call% dk_info "'%myPath%' is a directory") else (%dk_call% dk_info "'%myPath%' is NOT a directory")
	::###### Using if ERRORLEVEL
	%dk_call% dk_isDirectory "%myPath%"
    if not ERRORLEVEL 1 (%dk_call% dk_info "'%myPath%' is a directory") else (%dk_call% dk_info "'%myPath%' is NOT a directory")
	::###### Using && and || conditionals
    %dk_call% dk_isDirectory "%myPath%" && %dk_call% dk_info "'%myPath%' is a directory" || %dk_call% dk_info "'%myPath%' is NOT a directory"
	
	::############ C:/Windows/ ############
	::###### Using if return value
	set "myPath=C:/Windows/"
    %dk_call% dk_isDirectory "%myPath%"
    if %dk_isDirectory% equ 0 (%dk_call% dk_info "'%myPath%' is a directory") else (%dk_call% dk_info "'%myPath%' is NOT a directory")
	::###### Using if ERRORLEVEL
	%dk_call% dk_isDirectory "%myPath%"
    if not ERRORLEVEL 1 (%dk_call% dk_info "'%myPath%' is a directory") else (%dk_call% dk_info "'%myPath%' is NOT a directory")
	::###### Using && and || conditionals
    %dk_call% dk_isDirectory "%myPath%" && %dk_call% dk_info "'%myPath%' is a directory" || %dk_call% dk_info "'%myPath%' is NOT a directory"
	
	::############ C:\Windows\notepad.exe ############
    ::###### Using if return value
	set "myPath=C:\Windows\notepad.exe"
    %dk_call% dk_isDirectory "%myPath%"
    if %dk_isDirectory% equ 0 (%dk_call% dk_info "'%myPath%' is a directory") else (%dk_call% dk_info "'%myPath%' is NOT a directory")
	::###### Using if ERRORLEVEL
	%dk_call% dk_isDirectory "%myPath%"
    if not ERRORLEVEL 1 (%dk_call% dk_info "'%myPath%' is a directory") else (%dk_call% dk_info "'%myPath%' is NOT a directory")
    ::###### Using && and || conditionals
    %dk_call% dk_isDirectory "%myPath%" && %dk_call% dk_info "'%myPath%' is a directory" || %dk_call% dk_info "'%myPath%' is NOT a directory"
	
	::############ C:/NonExistent.exe ############
    ::###### Using if return value
	set "myPath=C:/NonExistent.exe"
    %dk_call% dk_isDirectory "%myPath%"
    if %dk_isDirectory% equ 0 (%dk_call% dk_info "'%myPath%' is a directory") else (%dk_call% dk_info "'%myPath%' is NOT a directory")
	::###### Using if ERRORLEVEL
	%dk_call% dk_isDirectory "%myPath%"
    if not ERRORLEVEL 1 (%dk_call% dk_info "'%myPath%' is a directory") else (%dk_call% dk_info "'%myPath%' is NOT a directory"
    ::###### Using && and || conditionals
    %dk_call% dk_isDirectory "%myPath%" && %dk_call% dk_info "'%myPath%' is a directory" || %dk_call% dk_info "'%myPath%' is NOT a directory"
	
	::############ C:/NonExistent ############
    ::###### Using if return value
	set "myPath=C:/NonExistent"
    %dk_call% dk_isDirectory "%myPath%"
    if %dk_isDirectory% equ 0 (%dk_call% dk_info "'%myPath%' is a directory") else (%dk_call% dk_info "'%myPath%' is NOT a directory")
	::###### Using if ERRORLEVEL
	%dk_call% dk_isDirectory "%myPath%"
    if not ERRORLEVEL 1 (%dk_call% dk_info "'%myPath%' is a directory") else (%dk_call% dk_info "'%myPath%' is NOT a directory")
    ::###### Using && and || conditionals
    %dk_call% dk_isDirectory "%myPath%" && %dk_call% dk_info "'%myPath%' is a directory" || %dk_call% dk_info "'%myPath%' is NOT a directory"
%endfunction%
