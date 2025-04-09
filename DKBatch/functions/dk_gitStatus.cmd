@echo off
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)

::################################################################################
::# dk_gitStatus()
::#
::#
:dk_gitStatus
setlocal
	%dk_call% dk_debugFunc 0

    %dk_call% dk_validate GIT_EXE "%dk_call% dk_installGit"
    "%GIT_EXE%" -C %DKBRANCH_DIR% status
%endfunction%







::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0

    %dk_call% dk_gitStatus
%endfunction%
