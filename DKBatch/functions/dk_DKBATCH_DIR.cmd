@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::####################################################################
::# dk_DKBATCH_DIR()
::#
::#
:dk_DKBATCH_DIR
    call dk_debugFunc 0
 ::setlocal
   
    if defined DKBATCH_DIR %return%
    
	%dk_call% dk_validate DKBRANCH_DIR "%dk_call% dk_DKBRANCH_DIR"
    set "DKBATCH_DIR=%DKBRANCH_DIR%\DKBatch"
	set "DKBATCH_FUNCTIONS_DIR=%DKBATCH_DIR%\functions"
	set "DKBATCH_FUNCTIONS_DIR_=%DKBATCH_DIR%\functions\"
    ::if not exist "%DKBATCH_DIR%" %dk_call% dk_makeDirectory "%DKBATCH_DIR%"
%endfunction%







::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
    call dk_debugFunc 0
 setlocal
 
    %dk_call% dk_DKBATCH_DIR
    %dk_call% dk_printVar DKBATCH_DIR
%endfunction%
