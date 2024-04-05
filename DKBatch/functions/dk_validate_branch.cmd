::dk_include_guard()

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: dk_validate_branch()
::
::
:dk_validate_branch
	call dk_verbose "dk_validate_branch(%*)"
	
    :: https://stackoverflow.com/a/33662275
    :: If the current folder matches the current branch set DKBRANCH, default to Development
    for %%I in (.) do set FOLDER=%%~nxI
        
    set "DKBRANCH=Development"
    if exist .git (
        "%GIT_EXE%" branch | find "* %FOLDER%" > NUL & IF ERRORLEVEL 0 (
            set "DKBRANCH=%FOLDER%"
        )
    )

    call dk_print_var DKBRANCH
    set "DKBRANCH_DIR=%DIGITALKNOB_DIR%\%DKBRANCH%"
	call dk_print_var DKBRANCH_DIR
    set "DKAPPS_DIR=%DKBRANCH_DIR%\DKApps"
	call dk_print_var DKAPPS_DIR
    set "DKCMAKE_DIR=%DKBRANCH_DIR%\DKCMake"
	call dk_print_var DKCMAKE_DIR
    set "DKPLUGINS_DIR=%DKBRANCH_DIR%\DKPlugins"
	call dk_print_var DKPLUGINS_DIR
    set "DK3RDPARTY_DIR=%DKBRANCH_DIR%\3rdParty"
	call dk_print_var DK3RDPARTY_DIR
    set "DKIMPORTS_DIR=%DK3RDPARTY_DIR%\_DKIMPORTS"
	call dk_print_var DKIMPORTS_DIR
	
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
    call dk_check_error
goto:eof