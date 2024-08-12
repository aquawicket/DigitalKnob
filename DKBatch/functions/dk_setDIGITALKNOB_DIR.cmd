@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd"

::call dk_source dk_createShortcut
::call dk_source dk_debugFunc
::call dk_source dk_error
::call dk_source dk_makeDirectory
::call dk_source dk_pinToQuickAccess
::call dk_source dk_setDKDESKTOP_DIR
::call dk_source dk_setDKHOME_DIR
::call dk_source dk_warning
::####################################################################
::# dk_setDIGITALKNOB_DIR()
::#
::#
:dk_setDIGITALKNOB_DIR
    call dk_debugFunc 0
	
    if defined DIGITALKNOB_DIR %dk_call% dk_warning "DIGITALKNOB_DIR already set to %DIGITALKNOB_DIR%" && goto:eof
	
    if not defined DKHOME_DIR %dk_call% dk_setDKHOME_DIR
	::if not defined DIGITALKNOB set "DIGITALKNOB=D i g i t a l K n o b"
	if not defined DIGITALKNOB set "DIGITALKNOB=digitalknob"
    set "DIGITALKNOB_DIR=%DKHOME_DIR%\%DIGITALKNOB%"

    :: create directory if it does not exist
    if not exist "%DIGITALKNOB_DIR%" %dk_call% dk_makeDirectory "%DIGITALKNOB_DIR%"

    :: create desktop shortcut if it doesn't exist
    if not defined DKDESKTOP_DIR %dk_call% dk_setDKDESKTOP_DIR
    if not exist "%DKDESKTOP_DIR%\digitalknob.lnk" %dk_call% dk_createShortcut "%DKDESKTOP_DIR%\digitalknob.lnk" "%DIGITALKNOB_DIR%"
	%dk_call% dk_pinToQuickAccess "%DIGITALKNOB_DIR%"
goto:eof






::call dk_source dk_printVar
::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc 0
	
	%dk_call% dk_setDIGITALKNOB_DIR
	%dk_call% dk_printVar DIGITALKNOB_DIR
	
	%dk_call% dk_setDIGITALKNOB_DIR
	%dk_call% dk_printVar DIGITALKNOB_DIR
goto:eof
