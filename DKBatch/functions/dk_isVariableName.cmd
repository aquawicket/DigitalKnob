@echo off
call %DKBATCH_FUNCTIONS_DIR_%DK.cmd

::####################################################################
::# dk_isVariableName(string rtn_var)
::#
::#	 https://stackoverflow.com/a/17584764
::#
:dk_isVariableName
	call dk_debugFunc
	if %__ARGC__% lss 1 call dk_error "%__FUNCTION__%:%__ARGV__% not enough arguments"
	if %__ARGC__% gtr 2 call dk_error "%__FUNCTION__%:%__ARGV__% too many arguments"

	::set "arg1=%~1"
	::if defined "%~1" call set "arg1=%%%arg1%%%"
	set "var="&for /f "delims=0123456789_abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ[]" %%i in ("%~1") do set bad_characters=%%i

	if not defined bad_characters (
		call dk_unset bad_characters
		if defined "%~2" (endlocal & call dk_set %2 true)
        (call )
		goto:eof
	)
	
	call dk_unset bad_characters
    if defined "%~2" (endlocal & call dk_set %2 false)
	(call)
goto:eof







::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc

	call dk_isVariableName 69         && call dk_info "is a valid variable name" || call dk_info "is NOT a valid variable name"
	set "myNumber=42"
	call dk_isVariableName %myNumber% && call dk_info "is a valid variable name" || call dk_info "is NOT a valid variable name"
	call dk_isVariableName myNumber   && call dk_info "is a valid variable name" || call dk_info "is NOT a valid variable name"  &:: FIXME
	call dk_isVariableName 0          && call dk_info "is a valid variable name" || call dk_info "is NOT a valid variable name"
	call dk_isVariableName 1          && call dk_info "is a valid variable name" || call dk_info "is NOT a valid variable name"
	call dk_isVariableName 1.23       && call dk_info "is a valid variable name" || call dk_info "is NOT a valid variable name"
	call dk_isVariableName -42        && call dk_info "is a valid variable name" || call dk_info "is NOT a valid variable name"
	call dk_isVariableName "36"       && call dk_info "is a valid variable name" || call dk_info "is NOT a valid variable name"
	
	call dk_isVariableName "36a"      && call dk_info "is a valid variable name" || call dk_info "is NOT a valid variable name"
	call dk_isVariableName word       && call dk_info "is a valid variable name" || call dk_info "is NOT a valid variable name"
	call dk_isVariableName 123456789  && call dk_info "is a valid variable name" || call dk_info "is NOT a valid variable name"
	call dk_isVariableName myArray[0] && call dk_info "is a valid variable name" || call dk_info "is NOT a valid variable name"
goto:eof