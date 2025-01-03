@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::####################################################################
::# dk_isVariableName(string rtn_var)
::#
::#  https://stackoverflow.com/a/17584764
::#
:dk_isVariableName
setlocal
	%dk_call% dk_debugFunc 1 2
 
    ::set "arg1=%~1"
    ::if defined "%~1" call set "arg1=%%%arg1%%%"
    set "var="&for /f "delims=0123456789_abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ[]" %%i in ("%~1") do set "bad_characters=%%i"

    if not defined bad_characters (
        set "bad_characters="
        if "%~2" neq "" (endlocal & set "%2=true")
        exit /b 0
    )
    
    set "bad_characters="
    if "%~2" neq "" (endlocal & call set "%2=false")
    exit /b 1
%endfunction%







::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0

    %dk_call% dk_isVariableName 69         && %dk_call% dk_info "is a valid variable name" || %dk_call% dk_info "is NOT a valid variable name"
    set "myNumber=42"
    %dk_call% dk_isVariableName %myNumber% && %dk_call% dk_info "is a valid variable name" || %dk_call% dk_info "is NOT a valid variable name"
    %dk_call% dk_isVariableName myNumber   && %dk_call% dk_info "is a valid variable name" || %dk_call% dk_info "is NOT a valid variable name"  &:: FIXME
    %dk_call% dk_isVariableName 0          && %dk_call% dk_info "is a valid variable name" || %dk_call% dk_info "is NOT a valid variable name"
    %dk_call% dk_isVariableName 1          && %dk_call% dk_info "is a valid variable name" || %dk_call% dk_info "is NOT a valid variable name"
    %dk_call% dk_isVariableName 1.23       && %dk_call% dk_info "is a valid variable name" || %dk_call% dk_info "is NOT a valid variable name"
    %dk_call% dk_isVariableName -42        && %dk_call% dk_info "is a valid variable name" || %dk_call% dk_info "is NOT a valid variable name"
    %dk_call% dk_isVariableName "36"       && %dk_call% dk_info "is a valid variable name" || %dk_call% dk_info "is NOT a valid variable name"
    
    %dk_call% dk_isVariableName "36a"      && %dk_call% dk_info "is a valid variable name" || %dk_call% dk_info "is NOT a valid variable name"
    %dk_call% dk_isVariableName word       && %dk_call% dk_info "is a valid variable name" || %dk_call% dk_info "is NOT a valid variable name"
    %dk_call% dk_isVariableName 123456789  && %dk_call% dk_info "is a valid variable name" || %dk_call% dk_info "is NOT a valid variable name"
    %dk_call% dk_isVariableName myArray[0] && %dk_call% dk_info "is a valid variable name" || %dk_call% dk_info "is NOT a valid variable name"
%endfunction%
