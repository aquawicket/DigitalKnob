::dk_include_guard()

::#####################################################################
::# dk_pick_type()
::#
::#
:dk_pick_type () {
	call dk_verbose "dk_pick_type(%*)"
	
    TITLE DigitalKnob - %APP% %TARGET_OS% %TYPE%
    echo.
    echo %APP% %TARGET_OS% %TYPE%     
    echo.
    echo 1) Debug
    echo 2) Release
    echo 3) All
	echo 4) none
    echo 5) Clear Screen
    echo 6) Go Back
    echo 7) Exit
    set choice=
    set /p choice=Please select a build type: 
    
    ::if not "%choice%"=="" set choice=%choice:~0,1%        ::What does this do? 
    if "%choice%"=="1" set "TYPE=Debug"    & goto:eof
    if "%choice%"=="2" set "TYPE=Release"  & goto:eof
    if "%choice%"=="3" set "TYPE=All"      & goto:eof
	if "%choice%"=="4" set "TYPE=none"     & goto:eof
    if "%choice%"=="5" call dk_clearScreen   & goto:eof
    if "%choice%"=="6" set "TARGET_OS="    & goto:eof
    if "%choice%"=="7" exit                & goto:eof
        
    echo %choice%: invalid selection, please try again
    set TYPE=
goto:eof