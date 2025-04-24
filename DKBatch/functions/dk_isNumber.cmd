<<<<<<< HEAD
@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::####################################################################
::# dk_isNumber(<in> rtn_var)
::#
::#  https://stackoverflow.com/a/17584764
::#
:dk_isNumber
    call dk_debugFunc 1 2
 setlocal
 
    set "arg1=%~1"
    if defined %~1 call set "arg1=%%%arg1%%%"
    set "var="&for /f "delims=0123456789.-" %%i in ("%arg1%") do set non_numeric=%%i

    if not defined non_numeric (
        %dk_call% dk_unset non_numeric
        if "%~2" neq "" (endlocal & set "%2=true")
        exit /b 0
    )
    
    %dk_call% dk_unset non_numeric
    if "%~2" neq "" (endlocal & set "%2=false")
    exit /b 1
=======
@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::#################################################################################################################################################


::####################################################################
::# dk_isNumber(<in> <ret:optional>)
::#
::#		Reference: https://stackoverflow.com/a/17584764
::#
:dk_isNumber
setlocal enableDelayedExpansion
	%dk_call% dk_debugFunc 1 2

	set "_val_=%~1"
	if defined %~1 (set "_val_=!%~1!")
	set "_val_=%_val_:.=%"
	set "_val_=%_val_:+=%"

	if 1%_val_:-=% equ +1%_val_:-=% (
		endlocal & set "dk_isNumber=0"
	) else (
		endlocal & set "dk_isNumber=-1"
	)

	if not "%~2" equ "" (set "%~2=%dk_isNumber%")
	exit /b %dk_isNumber%
>>>>>>> Development
%endfunction%







::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
<<<<<<< HEAD
    call dk_debugFunc 0
 setlocal

    %dk_call% dk_isNumber 69         && %dk_call% dk_info "is a number" || %dk_call% dk_info "is NOT a number"
    set "myNumber=42"
    %dk_call% dk_isNumber %myNumber% && %dk_call% dk_info "is a number" || %dk_call% dk_info "is NOT a number"
    %dk_call% dk_isNumber myNumber   && %dk_call% dk_info "is a number" || %dk_call% dk_info "is NOT a number"  &:: FIXME
    %dk_call% dk_isNumber 0          && %dk_call% dk_info "is a number" || %dk_call% dk_info "is NOT a number"
    %dk_call% dk_isNumber 1          && %dk_call% dk_info "is a number" || %dk_call% dk_info "is NOT a number"
    %dk_call% dk_isNumber 1.23       && %dk_call% dk_info "is a number" || %dk_call% dk_info "is NOT a number"
    %dk_call% dk_isNumber -42        && %dk_call% dk_info "is a number" || %dk_call% dk_info "is NOT a number"
    %dk_call% dk_isNumber "36"       && %dk_call% dk_info "is a number" || %dk_call% dk_info "is NOT a number"
    
    %dk_call% dk_isNumber "36a"      && %dk_call% dk_info "is a number" || %dk_call% dk_info "is NOT a number"
    %dk_call% dk_isNumber word       && %dk_call% dk_info "is a number" || %dk_call% dk_info "is NOT a number"
    %dk_call% dk_isNumber 123456789  && %dk_call% dk_info "is a number" || %dk_call% dk_info "is NOT a number"
=======
setlocal
	%dk_call% dk_debugFunc 0

	%dk_call% dk_isNumber 69			&& %dk_call% dk_info "is a number" || %dk_call% dk_info "is NOT a number"
	set "myNumber=42"
	%dk_call% dk_isNumber %myNumber%	&& %dk_call% dk_info "is a number" || %dk_call% dk_info "is NOT a number"
	%dk_call% dk_isNumber myNumber		&& %dk_call% dk_info "is a number" || %dk_call% dk_info "is NOT a number"
	%dk_call% dk_isNumber +0			&& %dk_call% dk_info "is a number" || %dk_call% dk_info "is NOT a number"
	%dk_call% dk_isNumber 0				&& %dk_call% dk_info "is a number" || %dk_call% dk_info "is NOT a number"
	%dk_call% dk_isNumber -0			&& %dk_call% dk_info "is a number" || %dk_call% dk_info "is NOT a number"
	%dk_call% dk_isNumber +1			&& %dk_call% dk_info "is a number" || %dk_call% dk_info "is NOT a number"
	%dk_call% dk_isNumber 1				&& %dk_call% dk_info "is a number" || %dk_call% dk_info "is NOT a number"
	%dk_call% dk_isNumber -1			&& %dk_call% dk_info "is a number" || %dk_call% dk_info "is NOT a number"
	%dk_call% dk_isNumber +1.23			&& %dk_call% dk_info "is a number" || %dk_call% dk_info "is NOT a number"
	%dk_call% dk_isNumber 1.23			&& %dk_call% dk_info "is a number" || %dk_call% dk_info "is NOT a number"
	%dk_call% dk_isNumber -1.23			&& %dk_call% dk_info "is a number" || %dk_call% dk_info "is NOT a number"
	%dk_call% dk_isNumber "+1.23"		&& %dk_call% dk_info "is a number" || %dk_call% dk_info "is NOT a number"
	%dk_call% dk_isNumber "1.23"		&& %dk_call% dk_info "is a number" || %dk_call% dk_info "is NOT a number"
	%dk_call% dk_isNumber "-1.23"		&& %dk_call% dk_info "is a number" || %dk_call% dk_info "is NOT a number"

	%dk_call% dk_isNumber "36a"			&& %dk_call% dk_info "is a number" || %dk_call% dk_info "is NOT a number"
	%dk_call% dk_isNumber word			&& %dk_call% dk_info "is a number" || %dk_call% dk_info "is NOT a number"
	%dk_call% dk_isNumber +word			&& %dk_call% dk_info "is a number" || %dk_call% dk_info "is NOT a number"
	%dk_call% dk_isNumber -word			&& %dk_call% dk_info "is a number" || %dk_call% dk_info "is NOT a number"
	%dk_call% dk_isNumber 123456789		&& %dk_call% dk_info "is a number" || %dk_call% dk_info "is NOT a number"
	%dk_call% dk_isNumber -123456789	&& %dk_call% dk_info "is a number" || %dk_call% dk_info "is NOT a number"
>>>>>>> Development
%endfunction%
