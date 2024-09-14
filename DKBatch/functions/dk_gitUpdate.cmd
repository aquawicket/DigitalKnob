@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::################################################################################
::# dk_gitUpdate(url, branch, NO_CONFIRM)
::#
::#
:dk_gitUpdate
 setlocal
    call dk_debugFunc 2 3
    
    if "%~1" neq "" (set "url=%~1") else (set "url=https://github.com/aquawicket/DigitalKnob.git")
    if "%~2" neq "" (set "branch=%~2") else (set "branch=Development")
    
    ::if "%3" neq "NO_CONFIRM" (
    ::    echo Git Update? Any local changes will be lost.
    ::    %dk_call% dk_confirm || goto:eof
    ::)
        
    %dk_call% dk_validate DKBRANCH_DIR "%dk_call% dk_validateBranch"
    %dk_call% dk_validate GIT_EXE "%dk_call% dk_installGit"
    
    if NOT exist "%DKBRANCH_DIR%\.git" ("%GIT_EXE%" clone %url% "%DKBRANCH_DIR%")

    cd "%DKBRANCH_DIR%"
    "%GIT_EXE%" pull --all
    "%GIT_EXE%" checkout -- .

    "%GIT_EXE%" checkout %branch%
    if NOT "%ERRORLEVEL%" == "0" (
        echo Remote has no %branch% branch. Creating...
        "%GIT_EXE%" checkout -b %branch% main
        "%GIT_EXE%" push --set-upstream origin %branch%
    )
%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
 setlocal
    call dk_debugFunc 0
    
    ::%dk_call% dk_gitUpdate
    %dk_call% dk_gitUpdate https://github.com/aquawicket/DigitalKnob.git Development
%endfunction%
