@echo off&::###### DK.cmd #########################################################################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


::################################################################################
::# DK_MINGW32_BASH environment
::#
%dk_call% dk_validate DKIMPORTS_DIR "%dk_call% dk_DKIMPORTS_DIR"
%dk_call% dk_validate MSYS2 "%dk_call% dk_depend msys2"
set "PATH=%MSYS2%\mingw32\bin;%MSYS2%\usr\bin;%PATH%"
%dk_call% dk_chdir %MSYS2%\mingw32

%dk_call% dk_clearScreen
%dk_call% dk_title "Digitalknob DK_MINGW32_BASH"
%dk_call% dk_info "############ DK_MINGW32_BASH environment ############"
%dk_call% dk_info ""
%MSYS2%/usr/bin/env MSYSTEM=MINGW32 /usr/bin/bash