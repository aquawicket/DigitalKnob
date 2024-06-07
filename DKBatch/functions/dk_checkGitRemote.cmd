@echo off
call DK

::##################################################################################
::# dk_checkGitRemote()
::#
::#
:dk_checkGitRemote () {
	call dk_debugFunc
	if %__ARGC__% neq 0 (call dk_error "%__FUNCTION__%(%__ARGC__%): incorrect number of arguments")

	call dk_validate DKBRANCH_DIR "call dk_validateBranch"
    if not exist "%DKBRANCH_DIR%\.git" ( call dk_warning "%DKBRANCH_DIR%\.git does not exist" )

	call dk_validate GIT_EXE "call dk_validateGit"
	
	cd "%DKBRANCH_DIR%"
	
    :: git remote update >nul 2>&1
    %GIT_EXE% remote update
	
    call dk_commandToVariable "%GIT_EXE% rev-parse --abbrev-ref HEAD" branch
    call dk_commandToVariable "%GIT_EXE% rev-list --count origin/%branch%..%branch%" ahead
    call dk_commandToVariable "%GIT_EXE% rev-list --count %branch%..origin/%branch%" behind

    echo %ahead% commits ahead, %behind% commits behind
goto:eof



:DKTEST ########################################################################

	call dk_checkGitRemote
