@echo off
if not defined DK_CMD (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*)

::####################################################################
::# dk_isVariableName(string rtn_var)
::#
::#  https://stackoverflow.com/a/17584764
::#
:dk_isVariableName
setlocal
	%dk_call% dk_debugFunc 1 2

	set "var="&for /f "delims=0123456789_abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ[]" %%i in ("%~1") do (set "bad_characters=%%i")

	if not defined bad_characters (
		set "dk_isVariableName=0"
	) else (
		set "dk_isVariableName=1"
	)

	set "bad_characters="
	endlocal & (
		if "%~2" neq "" (call set "%~2=%dk_isVariableName%")
		exit /b %dk_isVariableName%
	)
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
