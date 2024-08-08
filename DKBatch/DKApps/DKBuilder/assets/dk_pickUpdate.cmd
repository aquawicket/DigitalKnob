@echo off
call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd"

call dk_source dk_gitCheckRemote
call dk_source dk_clearCmakeCache
call dk_source dk_clearScreen
call dk_source dk_debugFunc
call dk_source dk_deleteTempFiles
call dk_source dk_echo
call dk_source dk_error
call dk_source dk_exit
call dk_source dk_gitCommit
call dk_source dk_gitUpdate
call dk_source dk_pullAssets
call dk_source dk_pushAssets
call dk_source dk_readCache
call dk_source dk_reload
call dk_source dk_removeAll
call dk_source dk_resetAll
call dk_source dk_set
call dk_source dk_setTitle
call dk_source dk_unset
::#####################################################################
::# dk_pickUpdate()
::#
::#
:dk_pickUpdate
	call dk_debugFunc 0
	
    call dk_setTitle DigitalKnob - %APP% %TARGET_OS% %TYPE%
    
    call dk_readCache _APP_ _TARGET_OS_ _TYPE_
	::call dk_printVar _APP_
	::call dk_printVar _TARGET_OS_
	::call dk_printVar _TYPE_

    call dk_echo
    call dk_gitCheckRemote

    call dk_echo
    if exist "%DKBRANCH_DIR%\cache" if "%_APP_%" neq "" if "%_TARGET_OS_%" neq "" if "%_TYPE_%" neq "" echo  0) Repeat cache [%_APP_% - %_TARGET_OS_% - %_TYPE_%]
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
    call dk_echo 
    echo  Press Enter To Skip
    call dk_unset choice
    set /p "choice=Choose a selection: " 
    
    ::if not '%choice%'=='' set choice=%choice:~0,1%        ::What does this do?
    if "%choice%"=="0" call dk_set APP %_APP_% & call dk_set TARGET_OS %_TARGET_OS_% & call dk_set TYPE %_TYPE_%
    if "%choice%"=="1" call dk_gitUpdate
    if "%choice%"=="2" call dk_gitCommit
    if "%choice%"=="3" call dk_pushAssets
    if "%choice%"=="4" call dk_pullAssets
    if "%choice%"=="5" call dk_resetAll
    if "%choice%"=="6" call dk_removeAll
    if "%choice%"=="7" call dk_clearScreen
    if "%choice%"=="8" call dk_clearCmakeCache & call dk_deleteTempFiles
    if "%choice%"=="9" call dk_reload
    if "%choice%"=="10" call dk_exit
        
    set UPDATE=true
goto:eof





::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc 0
	
	call dk_pickUpdate
goto:eof
