@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd"

::################################################################################
::# dk_gitUpdate(NO_CONFIRM)
::#
::#
:dk_gitUpdate
	call dk_debugFunc 0
	
    if "%1" neq "NO_CONFIRM" (
        echo Git Update? Any local changes will be lost.
		%dk_call% dk_confirm || goto:eof
    )
        
	%dk_call% dk_validate DKBRANCH_DIR "%dk_call% dk_validateBranch"
	%dk_call% dk_validate GIT_EXE "%dk_call% dk_installGit"
	
    if NOT exist "%DKBRANCH_DIR%\.git" ("%GIT_EXE%" clone https://github.com/aquawicket/DigitalKnob.git "%DKBRANCH_DIR%")

    cd "%DKBRANCH_DIR%"
    "%GIT_EXE%" pull --all
    "%GIT_EXE%" checkout -- .

    "%GIT_EXE%" checkout %DKBRANCH%
    if NOT "%ERRORLEVEL%" == "0" (
        echo Remote has no %DKBRANCH% branch. Creating...
        "%GIT_EXE%" checkout -b %DKBRANCH% main
        "%GIT_EXE%" push --set-upstream origin %DKBRANCH%
    )
goto:eof






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc 0
	
	%dk_call% dk_gitUpdate
goto:eof
