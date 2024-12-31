@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::################################################################################
::# dk_gitDiffSummary()
::#
::#
:dk_gitDiffSummary
    %dk_call% dk_debugFunc 0
 setlocal
 
    %dk_call% dk_validate GIT_EXE "%dk_call% dk_installGit"
    "%GIT_EXE%" -C %DKBRANCH_DIR% --no-pager diff --compact-summary
%endfunction%







::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
    %dk_call% dk_debugFunc 0
 setlocal
 
    %dk_call% dk_gitDiffSummary
%endfunction%
