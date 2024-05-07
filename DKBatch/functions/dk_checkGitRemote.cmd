@echo off
call DK

::##################################################################################
::# dk_checkGitRemote()
::#
::#
:dk_checkGitRemote () {
	call dk_debugFunc

	call dk_validate DKBRANCH_DIR dk_validateBranch
    if not exist "%DKBRANCH_DIR%\.git" goto:eof

	call dk_validate GIT_EXE dk_validateGit
    :: git remote update > /dev/null 2> /dev/null
    %GIT_EXE% remote update

	:: branch= $(git rev-parse --abbrev-ref HEAD)
    call dk_commandToVariable "%GIT_EXE% rev-parse --abbrev-ref HEAD" branch

    :: ahead= $(git rev-list --count origin/$branch..$branch)
    call dk_commandToVariable "%GIT_EXE% rev-list --count origin/%branch%..%branch%" ahead

    :: behind= $(git rev-list --count $branch..origin/$branch)
    call dk_commandToVariable "%GIT_EXE% rev-list --count %branch%..origin/%branch%" behind

    echo %ahead% commits ahead, %behind% commits behind
goto:eof



:DKTEST ########################################################################
call :dk_checkGitRemote
