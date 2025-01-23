@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::################################################################################
::# dk_getFileLine(filepath, match_string)
::#
::#
:dk_getFileLine
setlocal enableDelayedExpansion
	%dk_call% dk_debugFunc 2 
 
	set "_filepath_=%~f1"
	set "_filepath_=%_filepath_:/=\%"
    
    set /a "line=%~2" || for /f "delims=:" %%a in ('findstr /n /c:"%~2" "%_filepath_%"') do set "line=%%a"
    
    echo [91m  File: %_filepath_%: !line! [0m
    set /a n=1
    set /a min=!line!-15
    set /a max=!line!+15
    for /f "delims=" %%a in ('findstr /n /r /c:"^" "%_filepath_%"') do (
        if !n! LSS !max! (
            if !n! GTR !min! (
                set str=%%a
                set str=!str::=:    ! 
                if !n! equ !line! (
                    echo [30;41m^>  !str![0m
                ) else (
                    echo    !str!
                )
            )
        )       
        set /a n+=1
    )
    %dk_call% dk_echo
%endfunction%




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
    %dk_call% dk_debugFunc 0

    %dk_call% dk_getFileLine "../../README.md" "How to build"
%endfunction%
