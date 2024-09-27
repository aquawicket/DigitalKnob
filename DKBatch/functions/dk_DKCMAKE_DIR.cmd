@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::####################################################################
::# dk_DKCMAKE_DIR()
::#
::#
:dk_DKCMAKE_DIR
    call dk_debugFunc 0
:: setlocal
   
    if defined DKCMAKE_DIR %return%
    
	%dk_call% dk_validate DKBRANCH_DIR "%dk_call% dk_DKBRANCH_DIR"
    set "DKCMAKE_DIR=%DKBRANCH_DIR%\DKCMake"
    ::if not exist "%DKCMAKE_DIR%" %dk_call% dk_makeDirectory "%DKCMAKE_DIR%"
%endfunction%







::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
    call dk_debugFunc 0
 setlocal
 
    %dk_call% dk_DKCMAKE_DIR
    %dk_call% dk_printVar DKCMAKE_DIR
%endfunction%
