@echo off
call %DKBATCH_FUNCTIONS_DIR_%DK.cmd

::#####################################################################
::# dk_pickType()
::#
::#
:dk_pickType
	call dk_debugFunc
	if %__ARGC__% neq 0 (call dk_error "%__FUNCTION__%(%__ARGC__%): incorrect number of arguments")

    call dk_setTitle DigitalKnob - %APP% %TARGET_OS% %TYPE%
    call dk_echo
    call dk_echo "%APP% %TARGET_OS% %TYPE%"
    call dk_echo
    echo 1) Debug
    echo 2) Release
    echo 3) All
	echo 4) none
    echo 5) Clear Screen
    echo 6) Go Back
    echo 7) Exit
    call dk_unset choice
    set /p choice=Please select a build type: 

    ::if not "%choice%"=="" set choice=%choice:~0,1%        ::What does this do? 
    if "%choice%"=="1" call dk_set TYPE "Debug"    & goto:eof
    if "%choice%"=="2" call dk_set TYPE "Release"  & goto:eof
    if "%choice%"=="3" call dk_set TYPE "All"      & goto:eof
	if "%choice%"=="4" call dk_set TYPE "none"     & goto:eof
    if "%choice%"=="5" call dk_clearScreen         & goto:eof
    if "%choice%"=="6" call dk_unset TARGET_OS     & goto:eof
    if "%choice%"=="7" call dk_exit                & goto:eof

    call dk_echo %choice%: invalid selection, please try again
    call dk_unset TYPE
goto:eof




::####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ######
:DKTEST
	call dk_debugFunc

	call dk_pickType
goto:eof
