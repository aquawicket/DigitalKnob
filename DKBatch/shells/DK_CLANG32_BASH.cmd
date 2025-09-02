@echo off&::###### DK.cmd #########################################################################################################################
if NOT defined DKBATCH_FUNCTIONS_DIR_ (set DKBATCH_FUNCTIONS_DIR_=%USERPROFILE%/DigitalKnob/Development/DKBatch/functions/)
if NOT EXIST "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if NOT defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


::################################################################################
::# DK_CLANG32_BASH environment
::#
%dk_call% dk_validate DKIMPORTS_DIR "%dk_call% dk_DKIMPORTS_DIR"
%dk_call% dk_validate MSYS2 "%dk_call% dk_depend msys2"
set "PATH=%msys2%\clang32\bin;%msys2%\usr\bin;%PATH%"
%dk_call% dk_chdir %msys2%\clang32

%dk_call% dk_clearScreen
%dk_call% dk_title "Digitalknob DK_CLANG32_BASH"
%dk_call% dk_info "############ DK_CLANG32_BASH environment ############"
%dk_call% dk_info ""
%msys2%/usr/bin/env MSYSTEM=CLANG32 /usr/bin/bash