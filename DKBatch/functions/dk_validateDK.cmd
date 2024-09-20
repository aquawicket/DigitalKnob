@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::#####################################################################
::# dk_validateDK()
::#
::#
:dk_validateDK
 setlocal
    call dk_debugFunc 0
    
    if not defined DIGITALKNOB_DIR %dk_call% dk_setDIGITALKNOB_DIR

    set "DKBRANCH=Development"                                     &:: set the default branch
    if not defined GIT_EXE %dk_call% dk_installGit
    if not exist "%DIGITALKNOB_DIR%\%DKBRANCH%\.git"  %dk_call% dk_gitUpdate https://github.com/aquawicket/DigitalKnob.git Development
%endfunction%





::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
    call dk_debugFunc 0
 setlocal
    
    %dk_call% dk_validateDK
%endfunction%
