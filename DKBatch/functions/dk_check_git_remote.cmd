::dk_include_guard()

::##################################################################################
::# dk_check_git_remote()
::#
::#
:dk_check_git_remote () {
	call dk_verbose "dk_check_git_remote(%*)"
	
	if not exist "%GIT_EXE%" call dk_error GIT_EXE does not exist
	
    if not exist "%DKBRANCH_DIR%\.git" goto:eof
    
    :: git remote update > /dev/null 2> /dev/null
    %GIT_EXE% remote update
    
    :: branch= $(git rev-parse --abbrev-ref HEAD)
    call dk_command_to_variable "%GIT_EXE% rev-parse --abbrev-ref HEAD" branch
    
    :: ahead= $(git rev-list --count origin/$branch..$branch)
    call dk_command_to_variable "%GIT_EXE% rev-list --count origin/%branch%..%branch%" ahead
        
    :: behind= $(git rev-list --count $branch..origin/$branch)
    call dk_command_to_variable "%GIT_EXE% rev-list --count %branch%..origin/%branch%" behind
    
    echo %ahead% commits ahead, %behind% commits behind
goto:eof