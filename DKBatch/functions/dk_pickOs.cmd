@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::####################################################################
::# dk_pickOs(rtn_var:TARGET_OS)
::#
::#
:dk_pickOs TARGET_OS
    call dk_debugFunc 0 1
 ::setlocal
 
    %dk_call% dk_setTitle DigitalKnob - %APP% %TARGET_OS% %TYPE%
    %dk_call% dk_echo
    %dk_call% dk_echo %APP% %TARGET_OS% %TYPE%
       
    :: TODO: this list can be created using the DKCMake/toolchains files.
    %dk_call% dk_echo
    echo  1) %host_triple%
    %dk_call% dk_echo
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
    
    %dk_call% dk_echo 
    %dk_call% dk_echo "Please select an OS to build for"
    
    %dk_call% dk_keyboardInput choice
    ::%dk_call% dk_keyboardInputTimeout choice 1 60
        
    if "%choice%"=="1" endlocal & set "%1=%host_triple%"     & %return%
    if "%choice%"=="2" endlocal & set "%1=android_arm32"        & %return%
    if "%choice%"=="3" endlocal & set "%1=android_arm64"        & %return%
    if "%choice%"=="4" endlocal & set "%1=android_x86"          & %return%
    if "%choice%"=="5" endlocal & set "%1=android_x86_64"       & %return%
    if "%choice%"=="6" endlocal & set "%1=emscripten"           & %return%
    if "%choice%"=="7" endlocal & set "%1=ios_arm32"            & %return%
    if "%choice%"=="8" endlocal & set "%1=ios_arm64"            & %return%
    if "%choice%"=="9" endlocal & set "%1=ios_x86"              & %return%
    if "%choice%"=="10" endlocal & set "%1=ios_x86_64"          & %return%
    if "%choice%"=="11" endlocal & set "%1=iossim_arm32"        & %return%
    if "%choice%"=="12" endlocal & set "%1=iossim_arm64"        & %return%
    if "%choice%"=="13" endlocal & set "%1=iossim_x86"          & %return%
    if "%choice%"=="14" endlocal & set "%1=iossim_x86_64"       & %return%
    if "%choice%"=="15" endlocal & set "%1=linux_arm32"         & %return%
    if "%choice%"=="16" endlocal & set "%1=linux_arm64"         & %return%
    if "%choice%"=="17" endlocal & set "%1=linux_x86"           & %return%
    if "%choice%"=="18" endlocal & set "%1=linux_x86_64"        & %return%
    if "%choice%"=="19" endlocal & set "%1=mac_arm32"           & %return%
    if "%choice%"=="20" endlocal & set "%1=mac_arm64"           & %return%
    if "%choice%"=="21" endlocal & set "%1=mac_x86"             & %return%
    if "%choice%"=="22" endlocal & set "%1=mac_x86_64"          & %return%
    if "%choice%"=="23" endlocal & set "%1=raspberry_arm32"     & %return%
    if "%choice%"=="24" endlocal & set "%1=raspberry_arm64"     & %return%
    if "%choice%"=="25" endlocal & set "%1=raspberry_x86"       & %return%
    if "%choice%"=="26" endlocal & set "%1=raspberry_x86_64"    & %return%
    if "%choice%"=="27" endlocal & set "%1=win_arm32"           & %return%
    if "%choice%"=="28" endlocal & set "%1=win_arm64_clang"     & %return%
    if "%choice%"=="29" endlocal & set "%1=win_x86_mingw"       & %return%
    if "%choice%"=="30" endlocal & set "%1=win_x86_clang"       & %return%
    if "%choice%"=="31" endlocal & set "%1=win_x86_msvc"        & %return%
    if "%choice%"=="32" endlocal & set "%1=win_x86_64_mingw"    & %return%
    if "%choice%"=="33" endlocal & set "%1=win_x86_64_clang"    & %return%
    if "%choice%"=="34" endlocal & set "%1=win_x86_64_ucrt"     & %return%
    if "%choice%"=="35" endlocal & set "%1=win_x86_64_msvc"     & %return%
    if "%choice%"=="36" endlocal & set "%1=none"                & %return%
    if "%choice%"=="37" %dk_call% dk_clearScreen                & %return%
    if "%choice%"=="38" %dk_call% dk_unset APP                  & %return%
    if "%choice%"=="39" %dk_call% dk_exit                       & %return%

    %dk_call% dk_echo %choice%: invalid selection, please try again
    %dk_call% dk_unset TARGET_OS
%endfunction%




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
    call dk_debugFunc 0
 setlocal
    
    %dk_call% dk_pickOs
%endfunction%
