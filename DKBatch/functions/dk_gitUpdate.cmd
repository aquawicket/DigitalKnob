@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::################################################################################
::# dk_gitUpdate(url, branch, NO_CONFIRM)
::#
::#
:dk_gitUpdate
    call dk_debugFunc 2 3
 setlocal
 
    if "%~1" neq "" (set "_url_=%~1") else (set "_url_=https://github.com/aquawicket/DigitalKnob.git")
    if "%~2" neq "" (set "_branch_=%~2") else (set "_branch_=Development")
    
    ::if "%3" neq "NO_CONFIRM" (
    ::    echo Git Update? Any local changes will be lost.
    ::    %dk_call% dk_confirm || %return%
    ::)
        
    %dk_call% dk_validate DKBRANCH_DIR "%dk_call% dk_DKBRANCH_DIR"
    
	::if NOT exist "%DKBRANCH_DIR%\.git" (%dk_call% dk_gitClone %_url_% %_branch_% "%DKBRANCH_DIR%")
	
	if exist "%DKBRANCH_DIR%\.git" goto:cloned
	%dk_call% dk_isEmptyDirectory "%~3" || %dk_call% dk_copy "%~3" "%~3_BACKUP" OVERWRITE
	%dk_call% dk_validate GIT_EXE "%dk_call% dk_installGit"
	
	if not exist "%~3" ("%GIT_EXE%" -C "%~3" clone %~1 "%~3" && goto:cloned)
	%dk_call% dk_isEmptyDirectory "%~3" && ("%GIT_EXE%" -C "%~3" clone %~1 "%~3" && goto:cloned)

	::###### Fetch and checkout if directory already exists and is not empty
	"%GIT_EXE%" -C "%DKBRANCH_DIR%" init -b %~2
	"%GIT_EXE%" -C "%DKBRANCH_DIR%" remote add origin %~1
	"%GIT_EXE%" -C "%DKBRANCH_DIR%" fetch
	"%GIT_EXE%" -C "%DKBRANCH_DIR%" checkout -t origin/%~2 -f
	
	:cloned
    "%GIT_EXE%" -C "%DKBRANCH_DIR%"	pull --all
    "%GIT_EXE%" -C "%DKBRANCH_DIR%" checkout -- .
    "%GIT_EXE%" -C "%DKBRANCH_DIR%" checkout %_branch_% && %return%
    ::if "%ERRORLEVEL%" == "0" (%return%)

    %dk_call% dk_echo "Remote has no %_branch_% branch. Creating..."
    "%GIT_EXE%" -C %DKBRANCH_DIR% checkout -b %_branch_% main
    "%GIT_EXE%" -C %DKBRANCH_DIR% push --set-upstream origin %_branch_%

%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
    call dk_debugFunc 0
 setlocal
 
    ::%dk_call% dk_gitUpdate
    %dk_call% dk_gitUpdate https://github.com/aquawicket/DigitalKnob.git Development
%endfunction%
