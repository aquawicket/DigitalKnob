@echo off
call DK

::################################################################################
::# dk_gitUpdate(NO_CONFIRM)
::#
::#
:dk_gitUpdate () {
	call dk_debugFunc
	if %__ARGC__% NEQ 0 (dk_error "%__FUNCTION__%(): incorrect number of arguments")
	
    if "%1" neq "NO_CONFIRM" (
        echo Git Update? Any local changes will be lost.
		call dk_confirm || goto:eof
    )
        
	call dk_validate DKBRANCH_DIR dk_validateBranch
	call dk_validate GIT_EXE dk_validateGit
	
    if NOT exist "%DKBRANCH_DIR%\.git" ("%GIT_EXE%" clone https://github.com/aquawicket/DigitalKnob.git "%DKBRANCH_DIR%")
    call dk_checkError

    cd "%DKBRANCH_DIR%"
    "%GIT_EXE%" pull --all
    "%GIT_EXE%" checkout -- .
    call dk_checkError

    "%GIT_EXE%" checkout %DKBRANCH%
    if NOT "%ERRORLEVEL%" == "0" (
        echo Remote has no %DKBRANCH% branch. Creating...
        "%GIT_EXE%" checkout -b %DKBRANCH% main
        "%GIT_EXE%" push --set-upstream origin %DKBRANCH%
    )

    call dk_checkError
goto:eof


:DKTEST ########################################################################
call dk_gitUpdate