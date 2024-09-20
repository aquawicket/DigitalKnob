@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::####################################################################
::# dk_isEmptyDirectory(path rtn_var)
::#
::#
:dk_isEmptyDirectory
    call dk_debugFunc 1 2
 setlocal
	
	if not exist %~1\* %dk_call% dk_error "%~1 is not a directory" && exit /b 13
	
	for /F %%i in ('dir /b /a "%~1\*"') do (
		if "%~2" neq "" (endlocal & set "%2=false")
		exit /b 1
	)
	if "%~2" neq "" (endlocal & set "%2=true")
	exit /b 0
%endfunction%







::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
    call dk_debugFunc 0
 setlocal
    
    ::###### Using if return value
    %dk_call% dk_isEmptyDirectory "C:\Windows" result
    if "%result%" equ "true" (%dk_call% dk_info "'C:\Windows' is a directory") else (%dk_call% dk_info "'C:\Windows' is NOT a directory")
    %dk_call% dk_isEmptyDirectory "C:\NotADir" result
    if "%result%" equ "true" (%dk_call% dk_info "'C:\Windows' is a directory") else (%dk_call% dk_info "'C:\Windows' is NOT a directory")
    
    ::###### Using if ERRORLEVEL
    %dk_call% dk_isEmptyDirectory "C:\Windows"
    if not ERRORLEVEL 1 (%dk_call% dk_info "'C:\Windows' is a directory") else (%dk_call% dk_info "'C:\Windows' is NOT a directory")
    %dk_call% dk_isEmptyDirectory "C:\NotADir"
    if not ERRORLEVEL 1 (%dk_call% dk_info "'C:\Windows' is a directory") else (%dk_call% dk_info "'C:\Windows' is NOT a directory")
    
    ::###### Using && and || conditionals
    %dk_call% dk_isEmptyDirectory "C:\Windows" && %dk_call% dk_info "'C:\Windows' is a directory" || %dk_call% dk_info "'C:\Windows' is NOT a directory"
    %dk_call% dk_isEmptyDirectory "C:\NotADir" && %dk_call% dk_info "'C:\NotADir' is a directory" || %dk_call% dk_info "'C:\NotADir' is NOT a directory"
%endfunction%
