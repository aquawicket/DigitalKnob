@echo off
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)

::####################################################################
::# dk_isAlphanumeric(<string>, <output>:optional)
::#
::#  https://stackoverflow.com/a/17584764
::#
:dk_isAlphanumeric
setlocal
	%dk_call% dk_debugFunc 1 2
 
    ::set "arg1=%~1"
    ::if defined "%~1" call set "arg1=%%%arg1%%%"
    for /f "delims=0123456789_abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ" %%i in ("%~1") do set "bad_characters=%%i"

    if not defined bad_characters (
        set "bad_characters="
		endlocal & (
			set "dk_isAlphanumeric=true"
			if "%~2" neq "" set "%2=%dk_isAlphanumeric%"
		)
        exit /b 0
    )
    
    set "bad_characters="
    endlocal & (
		set "dk_isAlphanumeric=false"
		if "%~2" neq "" set "%2=%dk_isAlphanumeric%"
	)
    exit /b 1
%endfunction%







::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0

    %dk_call% dk_isAlphanumeric 69         && %dk_call% dk_info "is alphanumeric" || %dk_call% dk_info "is NOT alphanumeric"
    set "myNumber=42"
    %dk_call% dk_isAlphanumeric %myNumber% && %dk_call% dk_info "is alphanumeric" || %dk_call% dk_info "is NOT alphanumeric"
    %dk_call% dk_isAlphanumeric myNumber   && %dk_call% dk_info "is alphanumeric" || %dk_call% dk_info "is NOT alphanumeric"  &:: FIXME
    %dk_call% dk_isAlphanumeric 0          && %dk_call% dk_info "is alphanumeric" || %dk_call% dk_info "is NOT alphanumeric"
    %dk_call% dk_isAlphanumeric 1          && %dk_call% dk_info "is alphanumeric" || %dk_call% dk_info "is NOT alphanumeric"
    %dk_call% dk_isAlphanumeric 1.23       && %dk_call% dk_info "is alphanumeric" || %dk_call% dk_info "is NOT alphanumeric"
    %dk_call% dk_isAlphanumeric -42        && %dk_call% dk_info "is alphanumeric" || %dk_call% dk_info "is NOT alphanumeric"
    %dk_call% dk_isAlphanumeric "36"       && %dk_call% dk_info "is alphanumeric" || %dk_call% dk_info "is NOT alphanumeric"
    
    %dk_call% dk_isAlphanumeric "36a"      && %dk_call% dk_info "is alphanumeric" || %dk_call% dk_info "is NOT alphanumeric"
    %dk_call% dk_isAlphanumeric word       && %dk_call% dk_info "is alphanumeric" || %dk_call% dk_info "is NOT alphanumeric"
    %dk_call% dk_isAlphanumeric 123456789  && %dk_call% dk_info "is alphanumeric" || %dk_call% dk_info "is NOT alphanumeric"
    %dk_call% dk_isAlphanumeric myArray[0] && %dk_call% dk_info "is alphanumeric" || %dk_call% dk_info "is NOT alphanumeric"
%endfunction%
