@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::####################################################################
::# dk_pickOs(rtn_var:triple)
::#
::#
:dk_pickOs triple
    call dk_debugFunc 0 1
 ::setlocal
	
	set "default_target_env=clang"
	
    %dk_call% dk_title DigitalKnob - %APP% %triple% %DKBUILD_TYPE%
    %dk_call% dk_echo
    %dk_call% dk_echo %APP% %triple% %DKBUILD_TYPE%
       
    :: TODO: this list can be created using the DKCMake/toolchains files.
	%dk_call% dk_validate host_triple "%dk_call% dk_host_triple" 
    %dk_call% dk_echo
    echo  1) %host_triple%_%default_target_env%
    %dk_call% dk_echo
	echo  2) cosmopolitan
    echo  3) Android arm32
    echo  4) Android arm64
    echo  5) Android x86
    echo  6) Android x86_64
    echo  7) Emscripten
    echo  8) Ios arm32
    echo  9) Ios arm64
    echo 10) Ios x86
    echo 11) Ios x86_64
    echo 12) Iossim arm32
    echo 13) Iossim arm64
    echo 14) Iossim x86
    echo 15) Iossim x86_64
    echo 16) Linux arm32
    echo 17) Linux arm64
    echo 18) Linux x86
    echo 19) Linux x86_64
    echo 20) Mac arm32
    echo 21) Mac arm64
    echo 22) Mac x86
    echo 23) Mac x86_64
    echo 24) Raspberry arm32
    echo 25) Raspberry arm64
    echo 26) Raspberry x86
    echo 27) Raspberry x86_64
    echo 28) Windows arm32
    echo 29) Windows arm64     (clang)
    echo 30) Windows x86       (mingw)
    echo 31) Windows x86       (clang)
    echo 32) Windows x86       (msvc)
    echo 33) Windows x86_64    (mingw)
    echo 34) Windows x86_64    (clang)
    echo 35) Windows x86_64    (ucrt)
    echo 36) Windows x86_64    (msvc)
    echo 37) none
    echo 38) Clear Screen
    echo 39) Go Back
    echo 40) Exit    
    
    %dk_call% dk_echo 
    %dk_call% dk_echo "Please select an OS to build for"
    
    %dk_call% dk_keyboardInput choice
    ::%dk_call% dk_keyboardInputTimeout choice 1 60
        
    if "%choice%"=="1"  endlocal & set "%1=%host_triple%_%default_target_env%"	& %return%
	if "%choice%"=="2"  endlocal & set "%1=cosmopolitan"	    				& %return%
    if "%choice%"=="3"  endlocal & set "%1=android_arm32"        				& %return%
    if "%choice%"=="4"  endlocal & set "%1=android_arm64"        				& %return%
    if "%choice%"=="5"  endlocal & set "%1=android_x86"          				& %return%
    if "%choice%"=="6"  endlocal & set "%1=android_x86_64"       				& %return%
    if "%choice%"=="7"  endlocal & set "%1=emscripten"          				& %return%
    if "%choice%"=="8"  endlocal & set "%1=ios_arm32"            				& %return%
    if "%choice%"=="9"  endlocal & set "%1=ios_arm64"            				& %return%
    if "%choice%"=="10" endlocal & set "%1=ios_x86"              				& %return%
    if "%choice%"=="11" endlocal & set "%1=ios_x86_64"          				& %return%
    if "%choice%"=="12" endlocal & set "%1=iossim_arm32"        				& %return%
    if "%choice%"=="13" endlocal & set "%1=iossim_arm64"        				& %return%
    if "%choice%"=="14" endlocal & set "%1=iossim_x86"          				& %return%
    if "%choice%"=="15" endlocal & set "%1=iossim_x86_64"       				& %return%
    if "%choice%"=="16" endlocal & set "%1=linux_arm32"         				& %return%
    if "%choice%"=="17" endlocal & set "%1=linux_arm64"         				& %return%
    if "%choice%"=="18" endlocal & set "%1=linux_x86"           				& %return%
    if "%choice%"=="19" endlocal & set "%1=linux_x86_64"        				& %return%
    if "%choice%"=="20" endlocal & set "%1=mac_arm32"           				& %return%
    if "%choice%"=="21" endlocal & set "%1=mac_arm64"           				& %return%
    if "%choice%"=="22" endlocal & set "%1=mac_x86"             				& %return%
    if "%choice%"=="23" endlocal & set "%1=mac_x86_64"          				& %return%
    if "%choice%"=="24" endlocal & set "%1=raspberry_arm32"    				 	& %return%
    if "%choice%"=="25" endlocal & set "%1=raspberry_arm64"     				& %return%
    if "%choice%"=="26" endlocal & set "%1=raspberry_x86"       				& %return%
    if "%choice%"=="27" endlocal & set "%1=raspberry_x86_64"    				& %return%
    if "%choice%"=="28" endlocal & set "%1=win_arm32"          		 			& %return%
    if "%choice%"=="29" endlocal & set "%1=win_arm64_clang"     				& %return%
    if "%choice%"=="30" endlocal & set "%1=win_x86_mingw"       				& %return%
    if "%choice%"=="31" endlocal & set "%1=win_x86_clang"       				& %return%
    if "%choice%"=="32" endlocal & set "%1=win_x86_msvc"        				& %return%
    if "%choice%"=="33" endlocal & set "%1=win_x86_64_mingw"    				& %return%
    if "%choice%"=="34" endlocal & set "%1=win_x86_64_clang"    				& %return%
    if "%choice%"=="35" endlocal & set "%1=win_x86_64_ucrt"     				& %return%
    if "%choice%"=="36" endlocal & set "%1=win_x86_64_msvc"     				& %return%
    if "%choice%"=="37" endlocal & set "%1=none"                				& %return%
    if "%choice%"=="38" %dk_call% dk_clearScreen                				& %return%
    if "%choice%"=="39" %dk_call% dk_unset APP                  				& %return%
    if "%choice%"=="40" %dk_call% dk_exit                       				& %return%

    %dk_call% dk_echo %choice%: invalid selection, please try again
    %dk_call% dk_unset triple
%endfunction%




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
    call dk_debugFunc 0
 setlocal
    
    %dk_call% dk_pickOs
%endfunction%
