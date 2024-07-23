@echo off
call %DKBATCH_FUNCTIONS_DIR_%DK.cmd

call dk_source dk_debugFunc
call dk_source dk_error
call dk_source dk_warning
call dk_source dk_setDKHOME_DIR
call dk_source dk_makeDirectory
call dk_source dk_createShortcut
::####################################################################
::# dk_setDIGITALKNOB_DIR()
::#
::#
:dk_setDIGITALKNOB_DIR
    call dk_debugFunc
    if %__ARGC__% neq 0 call dk_error "%__FUNCTION__%:%__ARGV__% incorrect number of arguments"
	
	if defined DIGITALKNOB_DIR call dk_warning "DIGITALKNOB_DIR already set to %DIGITALKNOB_DIR%" && goto:eof
	
	if not defined DKHOME_DIR call dk_setDKHOME_DIR
	set "DIGITALKNOB_DIR=%DKHOME_DIR%\digitalknob"
	if not exist "%DIGITALKNOB_DIR%" call dk_makeDirectory "%DIGITALKNOB_DIR%"
	if not exist "%DKDESKTOP%\digitalknob.lnk" call dk_createShortcut "%DKDESKTOP%\digitalknob.lnk" "%DIGITALKNOB_DIR%"
goto:eof






call dk_source dk_printVar
::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc
	
	call dk_setDIGITALKNOB_DIR
	call dk_printVar DIGITALKNOB_DIR
	
	call dk_setDIGITALKNOB_DIR
	call dk_printVar DIGITALKNOB_DIR
goto:eof
