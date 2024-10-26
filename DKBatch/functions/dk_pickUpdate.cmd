@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::#####################################################################
::# dk_pickUpdate(rtn_var:UPDATE)
::#
::#
:dk_pickUpdate UPDATE
    call dk_debugFunc 0 1
 ::setlocal
 
    %dk_call% dk_setTitle DigitalKnob - %APP% %triple% %TYPE%
    
    %dk_call% dk_echo
    %dk_call% dk_commandExists "git" && %dk_call% dk_gitCheckRemote

    %dk_call% dk_readCache _APP_ _triple_ _TYPE
    
    %dk_call% dk_echo
    if exist "%DKCACHE_DIR%\cache" if "%_APP_%" neq "" if "%_triple_%" neq "" if "%_TYPE_%" neq "" echo  0) Repeat cache [%_APP_% - %_triple_% - %_TYPE_%]
    echo  1) Git Update
    echo  2) Git Commit
    echo  3) Download DigitalKnob
    echo  4) Push assets
    echo  5) Pull assets
    echo  6) Reset All
    echo  7) Remove All
    echo  8) Clear Screen
    echo  9) Clear cmake cache and .tmp files
    echo  10) Reload
    echo  11) Exit
    
    %dk_call% dk_echo "Choose a selection. Press enter to skip."
    %dk_call% dk_keyboardInput choice
    ::%dk_call% dk_keyboardInputTimeout choice 13 60
    
    if "%choice%"=="0" %dk_call% dk_set APP %_APP_% & %dk_call% dk_set triple %_triple_% & %dk_call% dk_set TYPE %_TYPE_%
    if "%choice%"=="1" %dk_call% dk_gitUpdate https://github.com/aquawicket/DigitalKnob.git Development
    if "%choice%"=="2" %dk_call% dk_gitCommit
    if "%choice%"=="3" %dk_call% dk_downloadDK
    if "%choice%"=="4" %dk_call% dk_pushAssets
    if "%choice%"=="5" %dk_call% dk_pullAssets
    if "%choice%"=="6" %dk_call% dk_resetAll
    if "%choice%"=="7" %dk_call% dk_removeAll
    if "%choice%"=="8" %dk_call% dk_clearScreen
    if "%choice%"=="9" %dk_call% dk_clearCmakeCache & %dk_call% dk_deleteTempFiles
    if "%choice%"=="10" %dk_call% dk_reload
    if "%choice%"=="11" %dk_call% dk_exit 0
       
    endlocal & set "UPDATE=1"
%endfunction%





::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
    call dk_debugFunc 0
 setlocal
    
    %dk_call% dk_pickUpdate
%endfunction%
