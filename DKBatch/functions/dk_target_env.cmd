@echo off
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%A IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpA")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)

::#####################################################################
::# dk_target_env(rtn_var:target_env)
::#
::#
:dk_target_env
::setlocal
	%dk_call% dk_debugFunc 0 1
 
    %dk_call% dk_echo
    %dk_call% dk_echo "%target_app% %target_os% %target_arch% %target_env% %target_type%"
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

    if "%choice%" equ "1" endlocal & set "%1=CLANGARM64"   && %return%
    if "%choice%" equ "2" endlocal & set "%1=CLANG32"   	&& %return%
    if "%choice%" equ "3" endlocal & set "%1=CLANG64"      && %return%
    if "%choice%" equ "4" endlocal & set "%1=MINGW32"      && %return%
	if "%choice%" equ "4" endlocal & set "%1=MINGW64"      && %return%
	if "%choice%" equ "4" endlocal & set "%1=UCRT64"      	&& %return%
	if "%choice%" equ "4" endlocal & set "%1=CYGWIN"      	&& %return%
	if "%choice%" equ "4" endlocal & set "%1=WSL"      	&& %return%
	if "%choice%" equ "4" endlocal & set "%1=MINGW32"      && %return%
    if "%choice%" equ "5" %dk_call% dk_clearScreen      	&& %return%
    if "%choice%" equ "6" %dk_call% dk_unset target_triple && %return%
    if "%choice%" equ "7" %dk_call% dk_exit             	&& %return%

    %dk_call% dk_echo %choice%: invalid selection, please try again
    %dk_call% dk_unset target_env
%endfunction%




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0

    %dk_call% dk_target_env
%endfunction%
