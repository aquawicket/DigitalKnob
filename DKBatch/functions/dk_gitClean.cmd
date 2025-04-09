@echo off
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)

::################################################################################
::# dk_gitClean()
::#
::#
:dk_gitClean
setlocal
	%dk_call% dk_debugFunc 0
 
    %dk_call% dk_validate GIT_EXE "%dk_call% dk_installGit"
	%dk_call% dk_validate DKBRANCH_DIR "%dk_call% dk_DKBRANCH_DIR"
    "%GIT_EXE%" -C %DKBRANCH_DIR% clean -fdx
%endfunction%




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0

    %dk_call% dk_gitClean 
%endfunction%
