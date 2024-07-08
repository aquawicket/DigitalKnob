@echo off
call %DKBATCH_FUNCTIONS_DIR_%DK.cmd

::####################################################################
::# dk_pickOs()
::#
::#
:dk_pickOs
	call dk_debugFunc
	if %__ARGC__% neq 0 call dk_error "%__FUNCTION__%:%__ARGV__% incorrect number of arguments"
	
    call dk_setTitle DigitalKnob - %APP% %TARGET_OS% %TYPE%
    call dk_echo
    call dk_echo %APP% %TARGET_OS% %TYPE%
       
    :: TODO: this list can be created using the DKCMake/toolchains files.
    call dk_echo
    echo  1) %HOST_TRIPLE%
    call dk_echo
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
    echo 29) Windows x86 (gcc)
    echo 30) Windows x86 (clang)
    echo 31) Windows x86 (msvc)
    echo 32) Windows x86_64 (gcc)
    echo 33) Windows x86_64 (clang)
    echo 34) Windows x86_64 (ucrt)
    echo 35) Windows x86_64 (msvc)
	echo 36) none
    echo 37) Clear Screen
    echo 38) Go Back
    echo 39) Exit    
    call dk_unset choice
    set /p choice=Please select an OS to build for: 
        
    ::if not "%choice%"=="" set choice=%choice:~0,1%        ::What does this do?
    if "%choice%"=="1" call dk_set TARGET_OS %HOST_TRIPLE%        & goto:eof
    if "%choice%"=="2" call dk_set TARGET_OS android_arm32        & goto:eof
    if "%choice%"=="3" call dk_set TARGET_OS android_arm64        & goto:eof
    if "%choice%"=="4" call dk_set TARGET_OS android_x86          & goto:eof
    if "%choice%"=="5" call dk_set TARGET_OS android_x86_64       & goto:eof
    if "%choice%"=="6" call dk_set TARGET_OS emscripten           & goto:eof
    if "%choice%"=="7" call dk_set TARGET_OS ios_arm32            & goto:eof
    if "%choice%"=="8" call dk_set TARGET_OS ios_arm64            & goto:eof
    if "%choice%"=="9" call dk_set TARGET_OS ios_x86              & goto:eof
    if "%choice%"=="10" call dk_set TARGET_OS ios_x86_64          & goto:eof
    if "%choice%"=="11" call dk_set TARGET_OS iossim_arm32        & goto:eof
    if "%choice%"=="12" call dk_set TARGET_OS iossim_arm64        & goto:eof
    if "%choice%"=="13" call dk_set TARGET_OS iossim_x86          & goto:eof
    if "%choice%"=="14" call dk_set TARGET_OS iossim_x86_64       & goto:eof
    if "%choice%"=="15" call dk_set TARGET_OS linux_arm32         & goto:eof
    if "%choice%"=="16" call dk_set TARGET_OS linux_arm64         & goto:eof
    if "%choice%"=="17" call dk_set TARGET_OS linux_x86           & goto:eof
    if "%choice%"=="18" call dk_set TARGET_OS linux_x86_64        & goto:eof
    if "%choice%"=="19" call dk_set TARGET_OS mac_arm32           & goto:eof
    if "%choice%"=="20" call dk_set TARGET_OS mac_arm64           & goto:eof
    if "%choice%"=="21" call dk_set TARGET_OS mac_x86             & goto:eof
    if "%choice%"=="22" call dk_set TARGET_OS mac_x86_64          & goto:eof
    if "%choice%"=="23" call dk_set TARGET_OS raspberry_arm32     & goto:eof
    if "%choice%"=="24" call dk_set TARGET_OS raspberry_arm64     & goto:eof
    if "%choice%"=="25" call dk_set TARGET_OS raspberry_x86       & goto:eof
    if "%choice%"=="26" call dk_set TARGET_OS raspberry_x86_64    & goto:eof
    if "%choice%"=="27" call dk_set TARGET_OS win_arm32           & goto:eof
    if "%choice%"=="28" call dk_set TARGET_OS win_arm64_clang     & goto:eof
    if "%choice%"=="29" call dk_set TARGET_OS win_x86_mingw       & goto:eof
    if "%choice%"=="30" call dk_set TARGET_OS win_x86_clang       & goto:eof
    if "%choice%"=="31" call dk_set TARGET_OS win_x86_msvc        & goto:eof
    if "%choice%"=="32" call dk_set TARGET_OS win_x86_64_mingw    & goto:eof
    if "%choice%"=="33" call dk_set TARGET_OS win_x86_64_clang    & goto:eof
    if "%choice%"=="34" call dk_set TARGET_OS win_x86_64_ucrt     & goto:eof
    if "%choice%"=="35" call dk_set TARGET_OS win_x86_64_msvc     & goto:eof
	if "%choice%"=="36" call dk_set TARGET_OS none                & goto:eof
    if "%choice%"=="37" call dk_clearScreen                       & goto:eof
    if "%choice%"=="38" call dk_set APP                           & goto:eof
    if "%choice%"=="39" call dk_exit                              & goto:eof
    call dk_echo %choice%: invalid selection, please try again
    call dk_unset TARGET_OS
goto:eof




::####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ######
:DKTEST
	call dk_debugFunc
	
	call dk_pickOs
goto:eof
