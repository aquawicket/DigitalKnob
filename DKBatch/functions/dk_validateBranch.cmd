call dk_includeGuard

::####################################################################
::# dk_validateBranch()
::#
::#
:dk_validateBranch () {
	call dk_debugFunc
	
    :: https://stackoverflow.com/a/33662275
    :: If the current folder matches the current branch set DKBRANCH, default to Development
    for %%I in (.) do set FOLDER=%%~nxI

    set DKBRANCH=Development
    if exist .git (
        "%GIT_EXE%" branch | find "* %FOLDER%" > NUL & IF ERRORLEVEL 0 (
            set DKBRANCH=%FOLDER%
        )
    )

    call dk_debug DKBRANCH
	
	if "%DIGITALKNOB_DIR%"==""  call dk_getDKPaths
    set "DKBRANCH_DIR=%DIGITALKNOB_DIR%\%DKBRANCH%"
    set "DKAPPS_DIR=%DKBRANCH_DIR%\DKApps"
    set "DKCMAKE_DIR=%DKBRANCH_DIR%\DKCMake"
    set "DKPLUGINS_DIR=%DKBRANCH_DIR%\DKPlugins"
    set "DK3RDPARTY_DIR=%DKBRANCH_DIR%\3rdParty"
    set "DKIMPORTS_DIR=%DK3RDPARTY_DIR%\_DKIMPORTS"

    :: make sure script is running from DKBRANCH_DIR
    ::if not %SCRIPT_DIR% == %DKBRANCH_DIR% (
    ::      if not exist %DKBRANCH_DIR%\%SCRIPT_NAME% (
    ::              copy %SCRIPT_DIR%\%SCRIPT_NAME% %DKBRANCH_DIR%\%SCRIPT_NAME%
    ::      )
    ::      echo .
    ::      echo "RELOADING SCRIPT TO -> %DKBRANCH_DIR%\%SCRIPT_NAME%"
    ::      pause
    ::      start "" "%DKBRANCH_DIR%\%SCRIPT_NAME%"
    ::      if exist %DKBRANCH_DIR%\%SCRIPT_NAME% (
    ::              del "%SCRIPT_DIR%\%SCRIPT_NAME%"
    ::      )
    ::      exit
    ::)
    call dk_checkError
goto:eof