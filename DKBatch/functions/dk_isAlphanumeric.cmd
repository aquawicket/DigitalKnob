@echo off
call %DKBATCH_FUNCTIONS_DIR_%DK.cmd

::####################################################################
::# dk_isAlphanumeric(string rtn_var)
::#
::#	 https://stackoverflow.com/a/17584764
::#
:dk_isAlphanumeric
	call dk_debugFunc
	if %__ARGC__% lss 1 call dk_error "%__FUNCTION__%:%__ARGV__% not enough arguments"
	if %__ARGC__% gtr 2 call dk_error "%__FUNCTION__%:%__ARGV__% too many arguments"

	::set "arg1=%~1"
	::if defined "%~1" call set "arg1=%%%arg1%%%"
	for /f "delims=0123456789_abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ" %%i in ("%~1") do set "bad_characters=%%i"

	if not defined bad_characters (
		set "bad_characters="
		if defined "%~2" (endlocal & set "%2=true")
        (call )
		goto:eof
	)
	
	set "bad_characters="
    if defined "%~2" (endlocal & call set "%2=false")
	(call)
goto:eof







::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc

	call dk_isAlphanumeric 69         && call dk_info "is alphanumeric" || call dk_info "is NOT alphanumeric"
	set "myNumber=42"
	call dk_isAlphanumeric %myNumber% && call dk_info "is alphanumeric" || call dk_info "is NOT alphanumeric"
	call dk_isAlphanumeric myNumber   && call dk_info "is alphanumeric" || call dk_info "is NOT alphanumeric"  &:: FIXME
	call dk_isAlphanumeric 0          && call dk_info "is alphanumeric" || call dk_info "is NOT alphanumeric"
	call dk_isAlphanumeric 1          && call dk_info "is alphanumeric" || call dk_info "is NOT alphanumeric"
	call dk_isAlphanumeric 1.23       && call dk_info "is alphanumeric" || call dk_info "is NOT alphanumeric"
	call dk_isAlphanumeric -42        && call dk_info "is alphanumeric" || call dk_info "is NOT alphanumeric"
	call dk_isAlphanumeric "36"       && call dk_info "is alphanumeric" || call dk_info "is NOT alphanumeric"
	
	call dk_isAlphanumeric "36a"      && call dk_info "is alphanumeric" || call dk_info "is NOT alphanumeric"
	call dk_isAlphanumeric word       && call dk_info "is alphanumeric" || call dk_info "is NOT alphanumeric"
	call dk_isAlphanumeric 123456789  && call dk_info "is alphanumeric" || call dk_info "is NOT alphanumeric"
	call dk_isAlphanumeric myArray[0] && call dk_info "is alphanumeric" || call dk_info "is NOT alphanumeric"
goto:eof
