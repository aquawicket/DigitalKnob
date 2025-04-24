<<<<<<< HEAD
@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*
=======
@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::#################################################################################################################################################

>>>>>>> Development

::##################################################################################
::# dk_gitCheckRemote()
::#
::#
:dk_gitCheckRemote
<<<<<<< HEAD
    call dk_debugFunc 0
 setlocal
 
    %dk_call% dk_validate DKBRANCH_DIR "%dk_call% dk_DKBRANCH_DIR"
    if not exist "%DKBRANCH_DIR%\.git" (%dk_call% dk_warning "%DKBRANCH_DIR%\.git does not exist" && %return%)

	%dk_call% dk_validate GIT_EXE "%dk_call% dk_installGit"
	::%dk_call% dk_cd "%DKBRANCH_DIR%"
	"%GIT_EXE%" -C %DKBRANCH_DIR% remote update
    
    %dk_call% dk_commandToVariable "%GIT_EXE%" "-C %DKBRANCH_DIR% rev-parse --abbrev-ref HEAD" branch
    %dk_call% dk_commandToVariable "%GIT_EXE%" "-C %DKBRANCH_DIR% rev-list --count origin/%branch%..%branch%" ahead
    %dk_call% dk_commandToVariable "%GIT_EXE%" "-C %DKBRANCH_DIR% rev-list --count %branch%..origin/%branch%" behind
=======
setlocal
	%dk_call% dk_debugFunc 0

    %dk_call% dk_validate DKBRANCH_DIR "%dk_call% dk_DKBRANCH_DIR"
    if not exist "%DKBRANCH_DIR%\.git" (%dk_call% dk_warning "%DKBRANCH_DIR%/.git does not exist" && %return%)

	%dk_call% dk_validate GIT_EXE "%dk_call% dk_installGit"
	::%dk_call% dk_chdir "%DKBRANCH_DIR%"
	"%GIT_EXE%" -C %DKBRANCH_DIR% remote update
    
    %dk_call% dk_exec "%GIT_EXE%" -C %DKBRANCH_DIR% rev-parse --abbrev-ref HEAD
	set "branch=%dk_exec%"
    %dk_call% dk_exec "%GIT_EXE%" -C %DKBRANCH_DIR% rev-list --count origin/%branch%..%branch%
	set "ahead=%dk_exec%"
    %dk_call% dk_exec "%GIT_EXE%" -C %DKBRANCH_DIR% rev-list --count %branch%..origin/%branch%
	set "behind=%dk_exec%"
>>>>>>> Development

    %dk_call% dk_echo "%ahead% commits ahead, %behind% commits behind"
%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
<<<<<<< HEAD
    call dk_debugFunc 0
 setlocal
 
=======
setlocal
	%dk_call% dk_debugFunc 0

>>>>>>> Development
    %dk_call% dk_gitCheckRemote
%endfunction%
