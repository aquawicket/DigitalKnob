@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::####################################################################
::# dk_setDIGITALKNOB_DIR()
::#
::#
:dk_setDIGITALKNOB_DIR
    call dk_debugFunc 0
:: setlocal

    if defined DIGITALKNOB_DIR %return%
            
    %dk_call% dk_setDKHOME_DIR
    ::if not defined DIGITALKNOB set "DIGITALKNOB=D i g i t a l K n o b"
    if not defined DIGITALKNOB set "DIGITALKNOB=digitalknob"
    set "DIGITALKNOB_DIR=%DKHOME_DIR%\%DIGITALKNOB%"
    if not exist "%DIGITALKNOB_DIR%" %dk_call% dk_makeDirectory "%DIGITALKNOB_DIR%"
%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
    call dk_debugFunc 0
:: setlocal
   
    %dk_call% dk_setDIGITALKNOB_DIR
    %dk_call% dk_printVar DIGITALKNOB_DIR
    
    %dk_call% dk_setDIGITALKNOB_DIR
    %dk_call% dk_printVar DIGITALKNOB_DIR
%endfunction%
