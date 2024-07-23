@echo off
call %DKBATCH_FUNCTIONS_DIR_%DK.cmd

call dk_source dk_debugFunc
call dk_source dk_error
call dk_source dk_warning
::####################################################################
::# dk_getDKHOME()
::#
::#
:dk_getDKHOME
    call dk_debugFunc
    if %__ARGC__% neq 0 call dk_error "%__FUNCTION__%:%__ARGV__% incorrect number of arguments"
	
	if defined DKHOME call dk_warning "DKHOME already set to %DKHOME%" && goto:eof
	
	if not defined HOMEDRIVE call dk_error "HOMEDRIVE is invalid"
	if not defined HOMEPATH call dk_error "HOMEPATH is invalid"
	set "DKHOME=%HOMEDRIVE%%HOMEPATH%"
goto:eof






call dk_source dk_printVar
::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc
	
	call dk_getDKHOME
	call dk_printVar DKHOME
	
	call dk_getDKHOME
	call dk_printVar DKHOME
goto:eof
