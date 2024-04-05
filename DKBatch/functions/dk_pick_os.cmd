::dk_include_guard()

::#################################################################################
:: dk_pick_os()
::
::
:dk_pick_os
	call dk_verbose "dk_pick_os(%*)"
	
    TITLE DigitalKnob - %APP% %TARGET_OS% %TYPE%
    echo.
    echo %APP% %TARGET_OS% %TYPE%
       
    :: TODO: this list can be created using the DKCMake/toolchains files.
    echo.
    echo  1) %NATIVE_TRIPLE%
    echo.
    echo  2) Android arm32
    echo  3) Android arm64
    echo  4) Android x86
    echo  5) Android x86_64
    echo  6) Emscripten
    echo  7) Ios arm32
    echo  8) Ios arm64
    echo  9) Ios x86
    echo 10) Ios x86_64
    echo 11) Iossim arm32
    echo 12) Iossim arm64
    echo 13) Iossim x86
    echo 14) Iossim x86_64
    echo 15) Linux arm32
    echo 16) Linux arm64
    echo 17) Linux x86
    echo 18) Linux x86_64
    echo 19) Mac arm32
    echo 20) Mac arm64
    echo 21) Mac x86
    echo 22) Mac x86_64
    echo 23) Raspberry arm32
    echo 24) Raspberry arm64
    echo 25) Raspberry x86
    echo 26) Raspberry x86_64
    echo 27) Windows arm32
    echo 28) Windows arm64 (clang)
    echo 29) Windows x86 (mingw)
    echo 30) Windows x86 (clang)
    echo 31) Windows x86 (msvc)
    echo 32) Windows x86_64 (mingw)
    echo 33) Windows x86_64 (clang)
    echo 34) Windows x86_64 (ucrt)
    echo 35) Windows x86_64 (msvc)
    echo 36) Clear Screen
    echo 37) Go Back
    echo 38) Exit    
    set choice=
    set /p choice=Please select an OS to build for: 
        
    ::if not "%choice%"=="" set choice=%choice:~0,1%        ::What does this do?
    if "%choice%"=="1" set "TARGET_OS=%NATIVE_TRIPLE%"     & goto:eof
    if "%choice%"=="2" set "TARGET_OS=android_arm32"       & goto:eof
    if "%choice%"=="3" set "TARGET_OS=android_arm64"       & goto:eof
    if "%choice%"=="4" set "TARGET_OS=android_x86"         & goto:eof
    if "%choice%"=="5" set "TARGET_OS=android_x86_64"      & goto:eof
    if "%choice%"=="6" set "TARGET_OS=emscripten"          & goto:eof
    if "%choice%"=="7" set "TARGET_OS=ios_arm32"           & goto:eof
    if "%choice%"=="8" set "TARGET_OS=ios_arm64"           & goto:eof
    if "%choice%"=="9" set "TARGET_OS=ios_x86"             & goto:eof
    if "%choice%"=="10" set "TARGET_OS=ios_x86_64"         & goto:eof
    if "%choice%"=="11" set "TARGET_OS=iossim_arm32"       & goto:eof
    if "%choice%"=="12" set "TARGET_OS=iossim_arm64"       & goto:eof
    if "%choice%"=="13" set "TARGET_OS=iossim_x86"         & goto:eof
    if "%choice%"=="14" set "TARGET_OS=iossim_x86_64"      & goto:eof
    if "%choice%"=="15" set "TARGET_OS=linux_arm32"        & goto:eof
    if "%choice%"=="16" set "TARGET_OS=linux_arm64"        & goto:eof
    if "%choice%"=="17" set "TARGET_OS=linux_x86"          & goto:eof
    if "%choice%"=="18" set "TARGET_OS=linux_x86_64"       & goto:eof
    if "%choice%"=="19" set "TARGET_OS=mac_arm32"          & goto:eof
    if "%choice%"=="20" set "TARGET_OS=mac_arm64"          & goto:eof
    if "%choice%"=="21" set "TARGET_OS=mac_x86"            & goto:eof
    if "%choice%"=="22" set "TARGET_OS=mac_x86_64"         & goto:eof
    if "%choice%"=="23" set "TARGET_OS=raspberry_arm32"    & goto:eof
    if "%choice%"=="24" set "TARGET_OS=raspberry_arm64"    & goto:eof
    if "%choice%"=="25" set "TARGET_OS=raspberry_x86"      & goto:eof
    if "%choice%"=="26" set "TARGET_OS=raspberry_x86_64"   & goto:eof
    if "%choice%"=="27" set "TARGET_OS=win_arm32"          & goto:eof
    if "%choice%"=="28" set "TARGET_OS=win_arm64_clang"    & goto:eof
    if "%choice%"=="29" set "TARGET_OS=win_x86_mingw"      & goto:eof
    if "%choice%"=="30" set "TARGET_OS=win_x86_clang"      & goto:eof
    if "%choice%"=="31" set "TARGET_OS=win_x86_msvc"       & goto:eof
    if "%choice%"=="32" set "TARGET_OS=win_x86_64_mingw"   & goto:eof
    if "%choice%"=="33" set "TARGET_OS=win_x86_64_clang"   & goto:eof
    if "%choice%"=="34" set "TARGET_OS=win_x86_64_ucrt"    & goto:eof
    if "%choice%"=="35" set "TARGET_OS=win_x86_64_msvc"    & goto:eof
    if "%choice%"=="36" call dk_clear_screen               & goto:eof
    if "%choice%"=="37" set "APP="                         & goto:eof
    if "%choice%"=="38" exit                               & goto:eof
    echo %choice%: invalid selection, please try again
    set TARGET_OS=
goto:eof