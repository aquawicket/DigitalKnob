@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::####################################################################
::# dk_DKPYTHON_DIR()
::#
::#
:dk_DKPYTHON_DIR
    call dk_debugFunc 0
 ::setlocal
   
    if defined DKPYTHON_DIR %return%
    
	%dk_call% dk_validate DKBRANCH_DIR "%dk_call% dk_DKBRANCH_DIR"
    set "DKPYTHON_DIR=%DKBRANCH_DIR%\DKPython"
	set "DKPYTHON_FUNCTIONS_DIR=%DKPYTHON_DIR%\functions"
	set "DKPYTHON_FUNCTIONS_DIR_=%DKPYTHON_DIR%\functions\"
    ::if not exist "%DKPYTHON_DIR%" %dk_call% dk_makeDirectory "%DKPYTHON_DIR%"
%endfunction%







::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
    call dk_debugFunc 0
 setlocal
 
    %dk_call% dk_DKPYTHON_DIR
    %dk_call% dk_printVar DKPYTHON_DIR
%endfunction%
