@echo off
call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd"

call dk_source dk_commandToVariable
call dk_source dk_gitCheckRemote
call dk_source dk_debugFunc
call dk_source dk_error
call dk_source dk_installGit
call dk_source dk_validate
call dk_source dk_validateBranch
call dk_source dk_warning
::##################################################################################
::# dk_gitCheckRemote()
::#
::#
:dk_gitCheckRemote
    call dk_debugFunc
    if %__ARGC__% neq 0 call dk_error "%__FUNCTION__%:%__ARGV__% incorrect number of arguments"

    call dk_validate DKBRANCH_DIR "call dk_validateBranch"
    if not exist "%DKBRANCH_DIR%\.git" ( call dk_warning "%DKBRANCH_DIR%\.git does not exist" && goto:eof )

    call dk_validate GIT_EXE "call dk_installGit"
	
    cd "%DKBRANCH_DIR%"
	
    :: git remote update >nul 2>&1
    %GIT_EXE% remote update
	
    call dk_commandToVariable "%GIT_EXE% rev-parse --abbrev-ref HEAD" branch
    call dk_commandToVariable "%GIT_EXE% rev-list --count origin/%branch%..%branch%" ahead
    call dk_commandToVariable "%GIT_EXE% rev-list --count %branch%..origin/%branch%" behind

    echo %ahead% commits ahead, %behind% commits behind
goto:eof






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc
	
	call dk_gitCheckRemote
goto:eof
