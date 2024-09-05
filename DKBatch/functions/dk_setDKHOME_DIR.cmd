@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %0

::####################################################################
::# dk_setDKHOME_DIR()
::#
::#
:dk_setDKHOME_DIR
:: setlocal
    call dk_debugFunc 0
    
    if defined DKHOME_DIR %dk_call% dk_warning "DKHOME_DIR already set to %DKHOME_DIR%" && goto:eof
    
    if not defined HOMEDRIVE %dk_call% dk_error "HOMEDRIVE is invalid"
    if not defined HOMEPATH %dk_call% dk_error "HOMEPATH is invalid"
    set "DKHOME_DIR=%HOMEDRIVE%%HOMEPATH%"
    if not exist %DKHOME_DIR% %dk_call% dk_error "DKHOME_DIR:%DKHOME_DIR% does not exist"
%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
 setlocal
    call dk_debugFunc 0
    
    %dk_call% dk_setDKHOME_DIR
    %dk_call% dk_printVar DKHOME_DIR
    
    %dk_call% dk_setDKHOME_DIR
    %dk_call% dk_printVar DKHOME_DIR
%endfunction%
