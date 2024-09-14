@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::#################################################################################
::# dk_keepConsoleOpen()
::#
::#
:dk_keepConsoleOpen
 setlocal
    call dk_debugFunc 0
    
    if not defined in_subprocess (%ComSpec% /k set in_subprocess=y ^& %DKSCRIPT_PATH%) & exit ) :: keep window open
%endfunction%





::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
 setlocal
    call dk_debugFunc 0
    
    %dk_call% dk_keepConsoleOpen
%endfunction%
