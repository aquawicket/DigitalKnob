@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::#################################################################################
::# dk_postBuildMenu()
::#
::#
:dk_postBuildMenu
 setlocal
    call dk_debugFunc 0
    
    %dk_call% dk_setTitle DigitalKnob - %APP% %triple% %TYPE%
    %dk_call% dk_echo
    echo %APP% %triple% %TYPE%
        
    %dk_call% dk_echo
%endfunction%





::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
    call dk_debugFunc 0
 setlocal
    
    %dk_call% dk_postBuildMenu
%endfunction%
