@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::####################################################################
::# dk_getDKPaths()
::#
::#
:dk_getDKPaths
    call dk_debugFunc 0
:: setlocal

	%dk_call% dk_setDIGITALKNOB_DIR
    %dk_call% dk_setDKTOOLS_DIR
    %dk_call% dk_setDKDOWNLOAD_DIR
    %dk_call% dk_setDKTEMP_DIR
	%dk_call% dk_setDKDESKTOP_DIR
%endfunction%







::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
    call dk_debugFunc 0
 setlocal
 
    %dk_call% dk_getDKPaths
%endfunction%
