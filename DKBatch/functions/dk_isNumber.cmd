@echo off
call %DKBATCH_FUNCTIONS_DIR_%DK.cmd

::####################################################################
::# dk_isNumber(<in> rtn_var)
::#
::#	 https://stackoverflow.com/a/17584764
::#
:dk_isNumber
	call dk_debugFunc
	if %__ARGC__% lss 1 call dk_error "%__FUNCTION__%:%__ARGV__%: not enough arguments")
	if %__ARGC__% gtr 2 call dk_error "%__FUNCTION__%:%__ARGV__%: too many arguments")

	set "arg1=%~1"
	if defined %~1 call set "arg1=%%%arg1%%%"
	set "var="&for /f "delims=0123456789.-" %%i in ("%arg1%") do set non_numeric=%%i

	
	if not defined non_numeric (
		call dk_unset non_numeric
		if defined "%~2" (endlocal & call dk_set %2 true)
        (call )
		goto:eof
	)
	
	call dk_unset non_numeric
    if defined "%~2" (endlocal & call dk_set %2 false)
	(call)
goto:eof







::####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST #######
:DKTEST
	call dk_debugFunc

	call dk_isNumber 69         && call dk_info "is a number" || call dk_info "is NOT a number"
	set "myNumber=42"
	call dk_isNumber %myNumber% && call dk_info "is a number" || call dk_info "is NOT a number"
	call dk_isNumber myNumber   && call dk_info "is a number" || call dk_info "is NOT a number"  &:: FIXME
	call dk_isNumber 0          && call dk_info "is a number" || call dk_info "is NOT a number"
	call dk_isNumber 1          && call dk_info "is a number" || call dk_info "is NOT a number"
	call dk_isNumber 1.23       && call dk_info "is a number" || call dk_info "is NOT a number"
	call dk_isNumber -42        && call dk_info "is a number" || call dk_info "is NOT a number"
	call dk_isNumber "36"       && call dk_info "is a number" || call dk_info "is NOT a number"
	
	call dk_isNumber "36a"      && call dk_info "is a number" || call dk_info "is NOT a number"
	call dk_isNumber word       && call dk_info "is a number" || call dk_info "is NOT a number"
	call dk_isNumber 123456789  && call dk_info "is a number" || call dk_info "is NOT a number"
goto:eof
