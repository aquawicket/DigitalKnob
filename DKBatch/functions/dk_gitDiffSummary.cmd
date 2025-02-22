@echo off
if not defined DK_CMD (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*)

::################################################################################
::# dk_gitDiffSummary()
::#
::#
:dk_gitDiffSummary
setlocal
	%dk_call% dk_debugFunc 0

    %dk_call% dk_validate GIT_EXE "%dk_call% dk_installGit"
    "%GIT_EXE:/=\%" -C %DKBRANCH_DIR% --no-pager diff --compact-summary
%endfunction%







::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0

    %dk_call% dk_gitDiffSummary
%endfunction%
