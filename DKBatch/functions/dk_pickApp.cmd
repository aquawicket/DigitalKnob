@echo off
call %DKBATCH_FUNCTIONS_DIR_%DK.cmd

call dk_source dk_clearScreen
call dk_source dk_debugFunc
call dk_source dk_echo
call dk_source dk_enterManually
call dk_source dk_error
call dk_source dk_exit
call dk_source dk_readCache
call dk_source dk_readCache
call dk_source dk_reload
call dk_source dk_set
call dk_source dk_unset
::#####################################################################
::# dk_pickApp()
::#
::#
:dk_pickApp
    call dk_debugFunc
    if %__ARGC__% neq 0 call dk_error "%__FUNCTION__%:%__ARGV__% incorrect number of arguments"

    call dk_setTitle DigitalKnob - %APP% %TARGET_OS% %TYPE%

    call dk_readCache _APP_ _TARGET_OS_ _TYPE_

    call dk_echo
    if exist "%DKBRANCH_DIR%\cache" if "%_APP_%" neq "" if "%_TARGET_OS_%" neq "" if "%_TYPE_%" neq "" echo  0) Repeat cache [%_APP_% - %_TARGET_OS_% - %_TYPE_%]
    echo  1) HelloWorld
    echo  2) DKCore
    echo  3) DKJavascript
    echo  4) DKSDL
    echo  5) DKSDLRml
    echo  6) DKDomTest
    echo  7) DKTestAll
    echo  8) Enter Manually
    echo  9) Clear Screen
    echo 10) Reload
    echo 11) Go Back
    echo 12) Exit
    call dk_unset choice
    set /p choice=Please select an app to build: 

    ::if not '%choice%'=='' set choice=%choice:~0,1%        ::What does this do?
    if "%choice%"=="0"  call dk_set APP %_APP_% & call dk_set TARGET_OS %_TARGET_OS_% & call dk_set TYPE %_TYPE_% & goto:eof
    if "%choice%"=="1"  call dk_set APP HelloWorld   & goto:eof
    if "%choice%"=="2"  call dk_set APP DKCore       & goto:eof
    if "%choice%"=="3"  call dk_set APP DKJavascript & goto:eof
    if "%choice%"=="4"  call dk_set APP DKSDL        & goto:eof
    if "%choice%"=="5"  call dk_set APP DKSDLRml     & goto:eof
    if "%choice%"=="6"  call dk_set APP DKDomTest    & goto:eof
    if "%choice%"=="7"  call dk_set APP DKTestAll    & goto:eof
    if "%choice%"=="8"  call dk_enterManually        & goto:eof
    if "%choice%"=="9"  call dk_clearScreen          & goto:eof
    if "%choice%"=="10" call dk_reload               & goto:eof
    if "%choice%"=="11" call dk_unset UPDATE         & goto:eof
    if "%choice%"=="12" call dk_exit                 & goto:eof

    call dk_echo "%choice%: invalid selection, please try again"
    call dk_unset APP
goto:eof



::####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ######
:DKTEST
	call dk_debugFunc

	call dk_pickApp
goto:eof
