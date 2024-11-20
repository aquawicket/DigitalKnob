@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::################################################################################
::# dk_gitUpdate(url, branch, NO_CONFIRM)
::#
::#
:dk_gitUpdate
    call dk_debugFunc 2 3
 setlocal
 
    if "%~1" neq "" (set "url=%~1") else (set "url=https://github.com/aquawicket/DigitalKnob.git")
    if "%~2" neq "" (set "branch=%~2") else (set "branch=Development")
    
    ::if "%3" neq "NO_CONFIRM" (
    ::    echo Git Update? Any local changes will be lost.
    ::    %dk_call% dk_confirm || %return%
    ::)
        
    %dk_call% dk_validate DKBRANCH_DIR "%dk_call% dk_DKBRANCH_DIR"
    %dk_call% dk_validate GIT_EXE "%dk_call% dk_installGit"
    
    if NOT exist "%DKBRANCH_DIR%\.git" ("%GIT_EXE%" clone %url% "%DKBRANCH_DIR%")

    ::%dk_call% dk_cd "%DKBRANCH_DIR%"
    "%GIT_EXE%" -C %DKBRANCH_DIR% pull --all
    "%GIT_EXE%" -C %DKBRANCH_DIR% checkout -- .

    "%GIT_EXE%" -C %DKBRANCH_DIR% checkout %branch%
    if NOT "%ERRORLEVEL%" == "0" (
        %dk_call% dk_echo "Remote has no %branch% branch. Creating..."
        "%GIT_EXE%" -C %DKBRANCH_DIR% checkout -b %branch% main
        "%GIT_EXE%" -C %DKBRANCH_DIR% push --set-upstream origin %branch%
    )
%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
    call dk_debugFunc 0
 setlocal
 
    ::%dk_call% dk_gitUpdate
    %dk_call% dk_gitUpdate https://github.com/aquawicket/DigitalKnob.git Development
%endfunction%
