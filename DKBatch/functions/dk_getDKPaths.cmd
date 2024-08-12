@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd"

call dk_source dk_debugFunc
call dk_source dk_error
call dk_source dk_setDKHOME_DIR
call dk_source dk_setDKDESKTOP_DIR
call dk_source dk_setDIGITALKNOB_DIR
call dk_source dk_setDKTOOLS_DIR
call dk_source dk_setDKDOWNLOAD_DIR
::####################################################################
::# dk_getDKPaths()
::#
::#
:dk_getDKPaths
    call dk_debugFunc 0
	
    if not defined DKHOME          call dk_setDKHOME_DIR
    if not defined DKDESKTOP       call dk_setDKDESKTOP_DIR
    if not defined DIGITALKNOB_DIR call dk_setDIGITALKNOB_DIR
    if not defined DKTOOLS_DIR     call dk_setDKTOOLS_DIR
    if not defined DKDOWNLOAD_DIR  call dk_setDKDOWNLOAD_DIR
goto:eof







::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc 0
	
	call dk_getDKPaths
goto:eof
