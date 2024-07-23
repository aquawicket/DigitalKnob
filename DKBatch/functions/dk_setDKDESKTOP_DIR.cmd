@echo off
call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd"

call dk_source dk_debugFunc
call dk_source dk_error
call dk_source dk_warning
call dk_source dk_setDKHOME_DIR
::####################################################################
::# dk_setDKDESKTOP_DIR()
::#
::#
:dk_setDKDESKTOP_DIR
    call dk_debugFunc
    if %__ARGC__% neq 0 call dk_error "%__FUNCTION__%:%__ARGV__% incorrect number of arguments"
	
	if defined DKDESKTOP_DIR call dk_warning "DKDESKTOP_DIR already set to %DKDESKTOP_DIR%" && goto:eof
	
	if not defined DKHOME_DIR call dk_setDKHOME_DIR
	set "DKDESKTOP_DIR=%DKHOME_DIR%\Desktop"
	if not exist %DKDESKTOP_DIR% call dk_error "DKDESKTOP_DIR:%DKDESKTOP_DIR% does not exist"
goto:eof






call dk_source dk_printVar
::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc
	
	call dk_setDKDESKTOP_DIR
	call dk_printVar DKDESKTOP_DIR
	
	call dk_setDKDESKTOP_DIR
	call dk_printVar DKDESKTOP_DIR
goto:eof
