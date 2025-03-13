@echo off
if not defined DK_CMD (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*)

::####################################################################
::# dk_isNumber(<in> <ret:optional>)
::#
::#  https://stackoverflow.com/a/17584764
::#
:dk_isNumber
setlocal enableDelayedExpansion
	%dk_call% dk_debugFunc 1 2
 
	set "number=%~1"
	if defined %~1 (set "number=!%~1!")
	set "number=%number:.=%"
	set "number=%number:+=%"
	::set number=%number:-=%
	
	if 1%number% equ +1%number% (
		echo %~1 is a number
		endlocal & (
			set "dk_isNumber=true"
			if "%~2" neq "" (set "%~2=%dk_isNumber%")
			exit /b 0
		)
	) else if 1%number:-=% equ +1%number:-=% (
		echo %~1 is a negative number
		endlocal & (
			set "dk_isNumber=true"
			if "%~2" neq "" (set "%~2=%dk_isNumber%")
			exit /b 0
		)
	) else (
		echo %~1 is not a number
		endlocal & (
			set "dk_isNumber=false"
			if "%~2" neq "" (set "%~2=%dk_isNumber%")
		)
	)
	exit /b 1
%endfunction%







::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0

    %dk_call% dk_isNumber 69         && %dk_call% dk_info "is a number" || %dk_call% dk_info "is NOT a number"
    set "myNumber=42"
    %dk_call% dk_isNumber %myNumber% && %dk_call% dk_info "is a number" || %dk_call% dk_info "is NOT a number"
    %dk_call% dk_isNumber myNumber   && %dk_call% dk_info "is a number" || %dk_call% dk_info "is NOT a number"  &:: FIXME
	%dk_call% dk_isNumber +0         && %dk_call% dk_info "is a number" || %dk_call% dk_info "is NOT a number"
    %dk_call% dk_isNumber 0          && %dk_call% dk_info "is a number" || %dk_call% dk_info "is NOT a number"
	%dk_call% dk_isNumber -0         && %dk_call% dk_info "is a number" || %dk_call% dk_info "is NOT a number"
	%dk_call% dk_isNumber "+0"       && %dk_call% dk_info "is a number" || %dk_call% dk_info "is NOT a number"
    %dk_call% dk_isNumber "0"        && %dk_call% dk_info "is a number" || %dk_call% dk_info "is NOT a number"
	%dk_call% dk_isNumber "-0"       && %dk_call% dk_info "is a number" || %dk_call% dk_info "is NOT a number"
    %dk_call% dk_isNumber +1         && %dk_call% dk_info "is a number" || %dk_call% dk_info "is NOT a number"
	%dk_call% dk_isNumber 1          && %dk_call% dk_info "is a number" || %dk_call% dk_info "is NOT a number"
	%dk_call% dk_isNumber -1         && %dk_call% dk_info "is a number" || %dk_call% dk_info "is NOT a number"
    %dk_call% dk_isNumber +1.23      && %dk_call% dk_info "is a number" || %dk_call% dk_info "is NOT a number"
	%dk_call% dk_isNumber 1.23       && %dk_call% dk_info "is a number" || %dk_call% dk_info "is NOT a number"
	%dk_call% dk_isNumber -1.23      && %dk_call% dk_info "is a number" || %dk_call% dk_info "is NOT a number"

    
    %dk_call% dk_isNumber "36a"      && %dk_call% dk_info "is a number" || %dk_call% dk_info "is NOT a number"
    %dk_call% dk_isNumber word       && %dk_call% dk_info "is a number" || %dk_call% dk_info "is NOT a number"
	%dk_call% dk_isNumber +word       && %dk_call% dk_info "is a number" || %dk_call% dk_info "is NOT a number"
	%dk_call% dk_isNumber -word       && %dk_call% dk_info "is a number" || %dk_call% dk_info "is NOT a number"
    %dk_call% dk_isNumber 123456789  && %dk_call% dk_info "is a number" || %dk_call% dk_info "is NOT a number"
	%dk_call% dk_isNumber -123456789 && %dk_call% dk_info "is a number" || %dk_call% dk_info "is NOT a number"
%endfunction%
