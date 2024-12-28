@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::#####################################################################
::# dk_pickEnvironment(rtn_var:DKBUILD_ENV)
::#
::#
:dk_pickEnvironment
    call dk_debugFunc 0 1
 ::setlocal
 
    %dk_call% dk_title DigitalKnob - %BUILD_APP% %BUILD_OS% %BUILD_ARCH% %BUILD_ENV% %DKBUILD_TYPE%
    %dk_call% dk_echo
    %dk_call% dk_echo "%BUILD_APP% %BUILD_OS% %BUILD_ARCH% %BUILD_ENV% %DKBUILD_TYPE%"
    %dk_call% dk_echo
    echo  1) ClangArm64
    echo  2) Clang32
    echo  3) Clang64
    echo  4) Mingw32
	echo  5) Mingw64
	echo  6) Ucrt64
	echo  7) MSVC
	echo  8) Cygwin
	echo  9) WSL
	echo 10) Clear Screen
    echo 11) Go Back
    echo 12) Exit
    
    %dk_call% dk_echo 
    %dk_call% dk_echo "Please select a build environment."
    
    %dk_call% dk_keyboardInput choice
    ::%dk_call% dk_keyboardInputTimeout choice 1 60 

    if "%choice%"=="1" endlocal & set "%1=CLANGARM64"   && %return%
    if "%choice%"=="2" endlocal & set "%1=CLANG32"   	&& %return%
    if "%choice%"=="3" endlocal & set "%1=CLANG64"      && %return%
    if "%choice%"=="4" endlocal & set "%1=MINGW32"      && %return%
	if "%choice%"=="4" endlocal & set "%1=MINGW64"      && %return%
	if "%choice%"=="4" endlocal & set "%1=UCRT64"      	&& %return%
	if "%choice%"=="4" endlocal & set "%1=CYGWIN"      	&& %return%
	if "%choice%"=="4" endlocal & set "%1=WSL"      	&& %return%
	if "%choice%"=="4" endlocal & set "%1=MINGW32"      && %return%
    if "%choice%"=="5" %dk_call% dk_clearScreen      	&& %return%
    if "%choice%"=="6" %dk_call% dk_unset triple     	&& %return%
    if "%choice%"=="7" %dk_call% dk_exit             	&& %return%

    %dk_call% dk_echo %choice%: invalid selection, please try again
    %dk_call% dk_unset DKBUILD_ENV
%endfunction%




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
    call dk_debugFunc 0
 setlocal

    %dk_call% dk_pickEnvironment
%endfunction%
