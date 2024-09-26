@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::####################################################################
::# dk_DKDESKTOP_DIR()
::#
::#
:dk_DKDESKTOP_DIR
    call dk_debugFunc 0
:: setlocal
   
    if defined DKDESKTOP_DIR %return%
    
    %dk_call% dk_validate DKHOME_DIR "%dk_call% dk_DKHOME_DIR"
    set "DKDESKTOP_DIR=%DKHOME_DIR%\Desktop"
    if not exist %DKDESKTOP_DIR%    %dk_call% dk_fatal "DKDESKTOP_DIR:%DKDESKTOP_DIR% does not exist"
%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
    call dk_debugFunc 0
 setlocal
 
    %dk_call% dk_DKDESKTOP_DIR
    %dk_call% dk_printVar DKDESKTOP_DIR
%endfunction%
