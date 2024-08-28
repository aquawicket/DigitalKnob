@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %0

::##################################################################################
::# dk_gitCheckRemote()
::#
::#
:dk_gitCheckRemote
 setlocal
    call dk_debugFunc 0

    %dk_call% dk_validate DKBRANCH_DIR "%dk_call% dk_validateBranch"
    if not exist "%DKBRANCH_DIR%\.git" (%dk_call% dk_warning "%DKBRANCH_DIR%\.git does not exist" && goto:eof )

	%dk_call% dk_validate GIT_EXE "%dk_call% dk_installGit"
	
    cd "%DKBRANCH_DIR%"
	
    :: git remote update >nul 2>&1
    "%GIT_EXE%" remote update
	
    %dk_call% dk_commandToVariable "%GIT_EXE%" "rev-parse --abbrev-ref HEAD" branch
    %dk_call% dk_commandToVariable "%GIT_EXE%" "rev-list --count origin/%branch%..%branch%" ahead
    %dk_call% dk_commandToVariable "%GIT_EXE%" "rev-list --count %branch%..origin/%branch%" behind

    echo %ahead% commits ahead, %behind% commits behind
goto:eof






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
 setlocal
	call dk_debugFunc 0
	
	%dk_call% dk_gitCheckRemote
goto:eof
