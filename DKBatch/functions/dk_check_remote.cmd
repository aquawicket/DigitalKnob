::include_guard()

:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: dk_check_remote()
::
::
:dk_check_remote
	call:dk_debug "dk_check_remote(%*)"
	
    if not exist "%DKBRANCH_DIR%\.git" goto:eof
    
    :: git remote update > /dev/null 2> /dev/null
    %GIT_EXE% remote update
    
    :: branch= $(git rev-parse --abbrev-ref HEAD)
    call:command_to_variable "%GIT_EXE% rev-parse --abbrev-ref HEAD" branch
    
    :: ahead= $(git rev-list --count origin/$branch..$branch)
    call:command_to_variable "%GIT_EXE% rev-list --count origin/%branch%..%branch%" ahead
        
    :: behind= $(git rev-list --count $branch..origin/$branch)
    call:command_to_variable "%GIT_EXE% rev-list --count %branch%..origin/%branch%" behind
    
    echo %ahead% commits ahead, %behind% commits behind
goto:eof