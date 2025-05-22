@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


::####################################################################
::# dk_isFile(path rtn_var)
::#
::#
:dk_isFile
%setlocal%
	%dk_call% dk_debugFunc 1 2

	%dk_call% dk_assertPath "%~1"

	if not exist "%~1" (
		set "dk_isFile=-1"
		exit /b %dk_isFile%
	)
	
	if not exist "%~1/*" (
		set "dk_isFile=0"
	) else (
		set "dk_isFile=1"
	)

    endlocal & (
		set "dk_isFile=%dk_isFile%"
		if "%~2" neq "" (set "%~2=%dk_isFile%")
		exit /b %dk_isFile%
	)
%endfunction%







::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0
  
	::############ C:/Windows/notepad.exe ############
    ::###### Using if return value
	set "myPath=C:/Windows/notepad.exe"
    %dk_call% dk_isFile "%myPath%"
    if "%dk_isFile%" equ "0" (%dk_call% dk_info "'%myPath%' is a file") else (%dk_call% dk_info "'%myPath%' is NOT a file")
	::###### Using if ERRORLEVEL
	%dk_call% dk_isFile "%myPath%"
    if not ERRORLEVEL 1 (%dk_call% dk_info "'%myPath%' is a file") else (%dk_call% dk_info "'%myPath%' is NOT a file")
    ::###### Using && and || conditionals
    %dk_call% dk_isFile "%myPath%" && %dk_call% dk_info "'%myPath%' is a file" || %dk_call% dk_info "'%myPath%' is NOT a file"
	
	::############ C:/Windows ############
	::###### Using if return value
	set "myPath=C:/Windows"
    %dk_call% dk_isFile "%myPath%"
    if %dk_isFile% equ 0 (%dk_call% dk_info "'%myPath%' is a file") else (%dk_call% dk_info "'%myPath%' is NOT a file")
	::###### Using if ERRORLEVEL
	%dk_call% dk_isFile "%myPath%"
    if not ERRORLEVEL 1 (%dk_call% dk_info "'%myPath%' is a file") else (%dk_call% dk_info "'%myPath%' is NOT a file")
	::###### Using && and || conditionals
    %dk_call% dk_isFile "%myPath%" && %dk_call% dk_info "'%myPath%' is a file" || %dk_call% dk_info "'%myPath%' is NOT a file"
	
	::############ C:/Windows/ ############
	::###### Using if return value
	set "myPath=C:/Windows/"
    %dk_call% dk_isFile "%myPath%"
    if %dk_isFile% equ 0 (%dk_call% dk_info "'%myPath%' is a file") else (%dk_call% dk_info "'%myPath%' is NOT a file")
	::###### Using if ERRORLEVEL
	%dk_call% dk_isFile "%myPath%"
    if not ERRORLEVEL 1 (%dk_call% dk_info "'%myPath%' is a file") else (%dk_call% dk_info "'%myPath%' is NOT a file")
	::###### Using && and || conditionals
    %dk_call% dk_isFile "%myPath%" && %dk_call% dk_info "'%myPath%' is a file" || %dk_call% dk_info "'%myPath%' is NOT a file"
	
	::############ C:\Windows\notepad.exe ############
    ::###### Using if return value
	set "myPath=C:/Windows/notepad.exe"
    %dk_call% dk_isFile "%myPath%"
    if %dk_isFile% equ 0 (%dk_call% dk_info "'%myPath%' is a file") else (%dk_call% dk_info "'%myPath%' is NOT a file")
	::###### Using if ERRORLEVEL
	%dk_call% dk_isFile "%myPath%"
    if not ERRORLEVEL 1 (%dk_call% dk_info "'%myPath%' is a file") else (%dk_call% dk_info "'%myPath%' is NOT a file")
    ::###### Using && and || conditionals
    %dk_call% dk_isFile "%myPath%" && %dk_call% dk_info "'%myPath%' is a file" || %dk_call% dk_info "'%myPath%' is NOT a file"
	
	::############ C:/NonExistent.exe ############
    ::###### Using if return value
	set "myPath=C:/NonExistent.exe"
    %dk_call% dk_isFile "%myPath%"
    if %dk_isFile% equ 0 (%dk_call% dk_info "'%myPath%' is a file") else (%dk_call% dk_info "'%myPath%' is NOT a file")
	::###### Using if ERRORLEVEL
	%dk_call% dk_isFile "%myPath%"
    if not ERRORLEVEL 1 (%dk_call% dk_info "'%myPath%' is a file") else (%dk_call% dk_info "'%myPath%' is NOT a file"
    ::###### Using && and || conditionals
    %dk_call% dk_isFile "%myPath%" && %dk_call% dk_info "'%myPath%' is a file" || %dk_call% dk_info "'%myPath%' is NOT a file"
	
	::############ C:/NonExistent ############
    ::###### Using if return value
	set "myPath=C:/NonExistent"
    %dk_call% dk_isFile "%myPath%"
    if %dk_isFile% equ 0 (%dk_call% dk_info "'%myPath%' is a file") else (%dk_call% dk_info "'%myPath%' is NOT a file")
	::###### Using if ERRORLEVEL
	%dk_call% dk_isFile "%myPath%"
    if not ERRORLEVEL 1 (%dk_call% dk_info "'%myPath%' is a file") else (%dk_call% dk_info "'%myPath%' is NOT a file")
    ::###### Using && and || conditionals
    %dk_call% dk_isFile "%myPath%" && %dk_call% dk_info "'%myPath%' is a file" || %dk_call% dk_info "'%myPath%' is NOT a file"
%endfunction%
