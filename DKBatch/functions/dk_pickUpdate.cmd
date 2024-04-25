::dk_includeGuard()

::#####################################################################
::# dk_pickUpdate()
::#
::#
:dk_pickUpdate () {
	call dk_debugFunc
	
	call dk_verbose "dk_pickUpdate(%*)"
	
    TITLE DigitalKnob - %APP% %TARGET_OS% %TYPE%
    
    call dk_readCache

    echo.
    call dk_checkGitRemote

    echo.
    if exist "%DKBRANCH_DIR%\cache" if "%_APP_%" NEQ "" if "%_TARGET_OS_%" NEQ "" if "%_TYPE_%" NEQ "" echo  0) Repeat cache [%_APP_% - %_TARGET_OS_% - %_TYPE_%]
    echo  1) Git Update
    echo  2) Git Commit
    echo  3) Push assets
    echo  4) Pull assets
    echo  5) Reset All
    echo  6) Remove All
    echo  7) Clear Screen
    echo  8) Clear cmake cache and .tmp files
    echo  9) Reload
    echo  10) Exit
    echo. 
    echo  Press Enter To Skip
    set choice=
    set /p "choice=Choose a selection: " 
    
    ::if not '%choice%'=='' set choice=%choice:~0,1%        ::What does this do?
    if "%choice%"=="0" set "APP=%_APP_%" & set "TARGET_OS=%_TARGET_OS_%" & set "TYPE=%_TYPE_%"
    if "%choice%"=="1" call dk_gitUpdate
    if "%choice%"=="2" call dk_gitCommit
    if "%choice%"=="3" call dk_pushAssets
    if "%choice%"=="4" call dk_pullAssets
    if "%choice%"=="5" call dk_resetAll
    if "%choice%"=="6" call dk_removeAll
    if "%choice%"=="7" call dk_clearScreen
    if "%choice%"=="8" call dk_deleteCache & call dk_deleteTempFiles
    if "%choice%"=="9" call dk_reload
    if "%choice%"=="10" exit
        
    set UPDATE=true
goto:eof