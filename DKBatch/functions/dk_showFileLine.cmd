@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::#################################################################################################################################################


::################################################################################
::# dk_showFileLine(filepath, match_string)
::# dk_showFileLine(filepath, line_number)
::#
::#
:dk_showFileLine
setlocal enableDelayedExpansion
	%dk_call% dk_debugFunc 2
 
	set "_filepath_=%~f1"
	set "_filepath_=%_filepath_:/=\%"
 
    if "!DE!" neq "" %dk_call% dk_error "%__FUNCTION__% requires delayed expansion"
    
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

  
    %dk_call% dk_showFileLine "../../README.md" 302
    %dk_call% dk_showFileLine "../../README.md" "How to build"
%endfunction%
