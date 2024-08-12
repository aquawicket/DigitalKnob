@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd"

::####################################################################
::# dk_getDKPaths()
::#
::#
:dk_getDKPaths
    call dk_debugFunc 0
	
    if not defined DKHOME          %dk_call% dk_setDKHOME_DIR
    if not defined DKDESKTOP       %dk_call% dk_setDKDESKTOP_DIR
    if not defined DIGITALKNOB_DIR %dk_call% dk_setDIGITALKNOB_DIR
    if not defined DKTOOLS_DIR     %dk_call% dk_setDKTOOLS_DIR
    if not defined DKDOWNLOAD_DIR  %dk_call% dk_setDKDOWNLOAD_DIR
goto:eof







::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc 0
	
	%dk_call% dk_getDKPaths
goto:eof
