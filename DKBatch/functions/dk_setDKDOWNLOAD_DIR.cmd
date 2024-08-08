@echo off
call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd"

call dk_source dk_debugFunc
call dk_source dk_error
call dk_source dk_warning
call dk_source dk_setDIGITALKNOB_DIR
call dk_source dk_makeDirectory
::####################################################################
::# dk_setDKDOWNLOAD_DIR()
::#
::#
:dk_setDKDOWNLOAD_DIR
    call dk_debugFunc 0
	
	if defined DKDOWNLOAD_DIR call dk_warning "DKDOWNLOAD_DIR already set to %DKDOWNLOAD_DIR%" && goto:eof
	
	if not defined DIGITALKNOB_DIR call dk_setDIGITALKNOB_DIR
	set "DKDOWNLOAD_DIR=%DIGITALKNOB_DIR%\download"
	if not exist "%DKDOWNLOAD_DIR%" call dk_makeDirectory "%DKDOWNLOAD_DIR%"
goto:eof






call dk_source dk_printVar
::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc 0
	
	call dk_setDKDOWNLOAD_DIR
	call dk_printVar DKDOWNLOAD_DIR
	
	call dk_setDKDOWNLOAD_DIR
	call dk_printVar DKDOWNLOAD_DIR
goto:eof
