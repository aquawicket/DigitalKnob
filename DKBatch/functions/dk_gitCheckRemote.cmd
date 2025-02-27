@echo off
if not defined DK_CMD (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*)

::##################################################################################
::# dk_gitCheckRemote()
::#
::#
:dk_gitCheckRemote
setlocal
	%dk_call% dk_debugFunc 0

    %dk_call% dk_validate DKBRANCH_DIR "%dk_call% dk_DKBRANCH_DIR"
    if not exist "%DKBRANCH_DIR%\.git" (%dk_call% dk_warning "%DKBRANCH_DIR%/.git does not exist" && %return%)

	%dk_call% dk_validate GIT_EXE "%dk_call% dk_installGit"
	::%dk_call% dk_cd "%DKBRANCH_DIR%"
	"%GIT_EXE%" -C %DKBRANCH_DIR% remote update
    
    %dk_call% dk_commandToVariable "%GIT_EXE%" "-C %DKBRANCH_DIR% rev-parse --abbrev-ref HEAD"
	set "branch=%dk_commandToVariable%"
    %dk_call% dk_commandToVariable "%GIT_EXE%" "-C %DKBRANCH_DIR% rev-list --count origin/%branch%..%branch%"
	set "ahead=%dk_commandToVariable%"
    %dk_call% dk_commandToVariable "%GIT_EXE%" "-C %DKBRANCH_DIR% rev-list --count %branch%..origin/%branch%"
	set "behind=%dk_commandToVariable%"

    %dk_call% dk_echo "%ahead% commits ahead, %behind% commits behind"
%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0

    %dk_call% dk_gitCheckRemote
%endfunction%
