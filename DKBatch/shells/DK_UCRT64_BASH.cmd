@echo off&::###### DK.cmd #########################################################################################################################
if NOT defined DKBATCH_FUNCTIONS_DIR_ (set DKBATCH_FUNCTIONS_DIR_=%USERPROFILE%/DigitalKnob/Development/DKBatch/functions/)
if NOT EXIST "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if NOT defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################

::################################################################################
::# DK_UCRT64_BASH environment
::#
%dk_call% dk_validate DKIMPORTS_DIR "%dk_call% dk_DKIMPORTS_DIR"
%dk_call% dk_validate MSYS2 "%dk_call% dk_depend msys2"
set "PATH=%MSYS2%\ucrt64\bin;%MSYS2%\usr\bin;%PATH%"
%dk_call% dk_chdir %MSYS2%\ucrt64

%dk_call% dk_clearScreen
%dk_call% dk_title "Digitalknob DK_UCRT64_BASH"
%dk_call% dk_info "############ DK_UCRT64_BASH environment ############"
%dk_call% dk_info ""
%MSYS2%/usr/bin/env MSYSTEM=UCRT64 /usr/bin/bash