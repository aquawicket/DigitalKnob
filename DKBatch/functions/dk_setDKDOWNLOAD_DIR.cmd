@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %0

::####################################################################
::# dk_setDKDOWNLOAD_DIR()
::#
::#
:dk_setDKDOWNLOAD_DIR
:: setlocal
    call dk_debugFunc 0
    
    if defined DKDOWNLOAD_DIR %dk_call% dk_warning "DKDOWNLOAD_DIR already set to %DKDOWNLOAD_DIR%" && goto:eof
    
    if not defined DIGITALKNOB_DIR %dk_call% dk_setDIGITALKNOB_DIR
    set "DKDOWNLOAD_DIR=%DIGITALKNOB_DIR%\download"
    if not exist "%DKDOWNLOAD_DIR%" %dk_call% dk_makeDirectory "%DKDOWNLOAD_DIR%"
goto:eof







::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
 setlocal
    call dk_debugFunc 0
    
    %dk_call% dk_setDKDOWNLOAD_DIR
    %dk_call% dk_printVar DKDOWNLOAD_DIR
    
    %dk_call% dk_setDKDOWNLOAD_DIR
    %dk_call% dk_printVar DKDOWNLOAD_DIR
goto:eof
