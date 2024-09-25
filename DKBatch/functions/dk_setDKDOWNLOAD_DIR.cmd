@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::####################################################################
::# dk_setDKDOWNLOAD_DIR()
::#
::#
:dk_setDKDOWNLOAD_DIR
    call dk_debugFunc 0
:: setlocal
   
    if defined DKDOWNLOAD_DIR %return%
    
    %dk_call% dk_setDIGITALKNOB_DIR
    set "DKDOWNLOAD_DIR=%DIGITALKNOB_DIR%\download"
    if not exist "%DKDOWNLOAD_DIR%" %dk_call% dk_makeDirectory "%DKDOWNLOAD_DIR%"
%endfunction%







::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
    call dk_debugFunc 0
 setlocal
 
    %dk_call% dk_setDKDOWNLOAD_DIR
    %dk_call% dk_printVar DKDOWNLOAD_DIR
%endfunction%
