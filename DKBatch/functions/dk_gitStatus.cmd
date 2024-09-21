@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::################################################################################
::# dk_gitStatus()
::#
::#
:dk_gitStatus
    call dk_debugFunc 0
 setlocal
 
    %dk_call% dk_validate GIT_EXE "%dk_call% dk_installGit"
    "%GIT_EXE%" status
%endfunction%







::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
    call dk_debugFunc 0
 setlocal
 
    %dk_call% dk_gitStatus
%endfunction%
