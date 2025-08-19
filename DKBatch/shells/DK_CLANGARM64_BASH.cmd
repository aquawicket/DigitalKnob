@echo off&::###### DK.cmd #########################################################################################################################
if NOT EXIST "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if NOT defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


::################################################################################
::# DK_CLANGARM64_BASH environment
::#
%dk_call% dk_validate DKIMPORTS_DIR "%dk_call% dk_DKIMPORTS_DIR"
%dk_call% dk_validate MSYS2 "%dk_call% dk_depend msys2"
set "PATH=%MSYS2%\clangarm64\bin;%MSYS2%\usr\bin;%PATH%"
%dk_call% dk_chdir %MSYS2%\clangarm64

%dk_call% dk_clearScreen
%dk_call% dk_title "Digitalknob DK_CLANGARM64_BASH"
%dk_call% dk_info "############ DK_CLANGARM64_BASH environment ############"
%dk_call% dk_info ""
%MSYS2%/usr/bin/env MSYSTEM=CLANGARM64 /usr/bin/bash