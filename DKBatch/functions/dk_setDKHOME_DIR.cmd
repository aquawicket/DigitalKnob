@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::####################################################################
::# dk_setDKHOME_DIR()
::#
::#
:dk_setDKHOME_DIR
    call dk_debugFunc 0
:: setlocal

    if defined DKHOME_DIR %return%
    
    if not defined HOMEDRIVE %dk_call% dk_error "HOMEDRIVE is invalid"
    if not defined HOMEPATH %dk_call% dk_error "HOMEPATH is invalid"
    set "DKHOME_DIR=%HOMEDRIVE%%HOMEPATH%"
    if not exist %DKHOME_DIR% %dk_call% dk_error "DKHOME_DIR:%DKHOME_DIR% does not exist"
%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
    call dk_debugFunc 0
 setlocal
 
    %dk_call% dk_setDKHOME_DIR
    %dk_call% dk_printVar DKHOME_DIR
%endfunction%
