@echo off
call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd"

call dk_source dk_debugFunc
call dk_source dk_error
call dk_source dk_warning
call dk_source dk_setDKHOME_DIR
call dk_source dk_setDKDESKTOP_DIR
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
	::if not defined DIGITALKNOB set "DIGITALKNOB=D i g i t a l K n o b"
	if not defined DIGITALKNOB set "DIGITALKNOB=digitalknob"
    set "DIGITALKNOB_DIR=%DKHOME_DIR%\%DIGITALKNOB%"

    :: create directory if it does not exist
    if not exist "%DIGITALKNOB_DIR%" call dk_makeDirectory "%DIGITALKNOB_DIR%"

    :: create desktop shortcut if it doesn't exist
    if not defined DKDESKTOP_DIR call dk_setDKDESKTOP_DIR
    if not exist "%DKDESKTOP_DIR%\digitalknob.lnk" call dk_createShortcut "%DKDESKTOP_DIR%\digitalknob.lnk" "%DIGITALKNOB_DIR%"
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
