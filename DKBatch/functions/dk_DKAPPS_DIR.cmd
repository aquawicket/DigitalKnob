@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::####################################################################
::# dk_DKAPPS_DIR()
::#
::#
:dk_DKAPPS_DIR
    call dk_debugFunc 0
:: setlocal
   
    if defined DKAPPS_DIR %return%
    
	%dk_call% dk_validate DKBRANCH_DIR "%dk_call% dk_DKBRANCH_DIR"
    set "DKAPPS_DIR=%DKBRANCH_DIR%\DKApps"
    ::if not exist "%DKAPPS_DIR%" %dk_call% dk_makeDirectory "%DKAPPS_DIR%"
%endfunction%







::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
    call dk_debugFunc 0
 setlocal
 
    %dk_call% dk_DKAPPS_DIR
    %dk_call% dk_printVar DKAPPS_DIR
%endfunction%
