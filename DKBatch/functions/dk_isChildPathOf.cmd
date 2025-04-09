@echo off
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%A IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpA")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)

::################################################################################
::# dk_isChildPathOf(haystack, needle, rtn_var)
::#
::#   https://en.wikipedia.org/wiki/Dirname
::#
:dk_isChildPathOf
setlocal
	%dk_call% dk_debugFunc 2 3
 
	set "_haystack_=%~1"
    set "_haystack_=%_haystack_:/=\%"									&:: replace all '/' with '\'
	set "_haystack_=%_haystack_::=%"									&:: remove all ':'
    if "%_haystack_:~0,1%" equ "\" set "_haystack_=%_haystack_:~1%"		&:: remove first character if it's a '\'
	
    set "_needle_=%~2"
    set "_needle_=%_needle_:/=\%"
    set "_needle_=%_needle_::=%"
    if "%_needle_:~0,1%" equ "\" set "_needle_=%_needle_:~1%"

    if not "x!_haystack_:%_needle_%=!x"=="x%_haystack_%x" (
        if "%~3" neq "" endlocal & (
			set "dk_isChildPathOf=true"
			if "%~3" neq "" set "%3=%dk_isChildPathOf%"
		)
        set "_haystack_="
        set "_needle_="
        exit /b 0
    )
    
    if "%~3" neq "" endlocal & (
		set "dk_isChildPathOf=false"
		if "%~3" neq "" set "%3=%dk_isChildPathOf%"
	)
    set "_haystack_="
    set "_needle_="
    exit /b 1
%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
    %dk_call% dk_debugFunc 0


    ::###### Using if return value
    %dk_call% dk_echo
    set "childPath=C:/Program Files/Internet Explorer/en-US"
    set "parentPath=C:/Program Files"
    %dk_call% dk_isChildPathOf "%childPath%" "%parentPath%" result
    if "%result%" equ "true" (%dk_call% dk_echo "the path is a child of the parentPath") else (%dk_call% dk_echo "the path is NOT a child of the parentPath")
    
    %dk_call% dk_echo
	set "childPath=/C:/Users/Administrator/digitalknob/nonexistant"
    set "parentPath=Administrator/digitalknob"
    %dk_call% dk_isChildPathOf "%childPath%" "%parentPath%" result
    if "%result%" equ "true" (%dk_call% dk_echo "the path is a child of the parentPath") else (%dk_call% dk_echo "the path is NOT a child of the parentPath")
    ::FIXME: ERRORLEVEL is still 1 
    
    
    ::###### Using if ERRORLEVEL
    %dk_call% dk_echo
    set "childPath=C:/Users/Administrator/digitalknob/DKPowershell/functions"
    set "parentPath=/C/Users/Administrator/digitalknob"
    %dk_call% dk_isChildPathOf "%childPath%" "%parentPath%"
    if not ERRORLEVEL 1 (%dk_call% dk_echo "the path is a child of the parentPath") else (%dk_call% dk_echo "the path is NOT a child of the parentPath")
    
    %dk_call% dk_echo
    set "childPath=/C:/Users/Administrator/digitalknob/"
    set "parentPath=C:/"
    %dk_call% dk_isChildPathOf "%childPath%" "%parentPath%"
    if not ERRORLEVEL 1 (%dk_call% dk_echo "the path is a child of the parentPath") else (%dk_call% dk_echo "the path is NOT a child of the parentPath")
    ::FIXME: ERRORLEVEL is still 1 
    
    
    ::###### Using && and || conditionals
    %dk_call% dk_echo
    set "childPath=C:/Users/"
    set "parentPath=D:/"
    %dk_call% dk_isChildPathOf "%childPath%" "%parentPath%" && (%dk_call% dk_echo "the path is a child of the parentPath") || (%dk_call% dk_echo "the path is NOT a child of the parentPath")

    %dk_call% dk_echo
    set "childPath=/C:/Users/Administrator/digitalknob/DKBash/functions"
    set "parentPath=C:/Users/Administrator/digitalknob/DKBash"
    %dk_call% dk_isChildPathOf "%childPath%" "%parentPath%" && (%dk_call% dk_echo "the path is a child of the parentPath") || (%dk_call% dk_echo "the path is NOT a child of the parentPath")
    ::FIXME: ERRORLEVEL is still 1
%endfunction%
