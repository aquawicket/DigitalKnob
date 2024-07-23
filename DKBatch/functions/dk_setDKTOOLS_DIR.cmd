@echo off
call %DKBATCH_FUNCTIONS_DIR_%DK.cmd

call dk_source dk_debugFunc
call dk_source dk_error
call dk_source dk_warning
call dk_source dk_setDIGITALKNOB_DIR
call dk_source dk_makeDirectory
::####################################################################
::# dk_setDKTOOLS_DIR()
::#
::#
:dk_setDKTOOLS_DIR
    call dk_debugFunc
    if %__ARGC__% neq 0 call dk_error "%__FUNCTION__%:%__ARGV__% incorrect number of arguments"
	
	if defined DKTOOLS_DIR call dk_warning "DKTOOLS_DIR already set to %DKTOOLS_DIR%" && goto:eof
	
	if not defined DIGITALKNOB_DIR call dk_setDIGITALKNOB_DIR
	set "DKTOOLS_DIR=%DIGITALKNOB_DIR%\DKTools"
	if not exist "%DKTOOLS_DIR%" call dk_makeDirectory "%DKTOOLS_DIR%"
goto:eof






call dk_source dk_printVar
::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc
	
	call dk_setDKTOOLS_DIR
	call dk_printVar DKTOOLS_DIR
	
	call dk_setDKTOOLS_DIR
	call dk_printVar DKTOOLS_DIR
goto:eof
