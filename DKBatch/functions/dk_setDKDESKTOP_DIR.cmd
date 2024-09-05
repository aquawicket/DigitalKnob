@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %0

::####################################################################
::# dk_setDKDESKTOP_DIR()
::#
::#
:dk_setDKDESKTOP_DIR
:: setlocal
    call dk_debugFunc 0
    
    if defined DKDESKTOP_DIR %dk_call% dk_warning "DKDESKTOP_DIR already set to %DKDESKTOP_DIR%" && goto:eof
    
    if not defined DKHOME_DIR %dk_call% dk_setDKHOME_DIR
    set "DKDESKTOP_DIR=%DKHOME_DIR%\Desktop"
    if not exist %DKDESKTOP_DIR% %dk_call% dk_error "DKDESKTOP_DIR:%DKDESKTOP_DIR% does not exist"
%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
 setlocal
    call dk_debugFunc 0
    
    %dk_call% dk_setDKDESKTOP_DIR
    %dk_call% dk_printVar DKDESKTOP_DIR
    
    %dk_call% dk_setDKDESKTOP_DIR
    %dk_call% dk_printVar DKDESKTOP_DIR
%endfunction%
