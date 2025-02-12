@echo off
if not exist "%DKBATCH_FUNCTIONS_DIR_%" set "DKBATCH_FUNCTIONS_DIR_=%CD%\..\functions\"
if not defined DKINIT (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*)

::################################################################################
::# DK_MSYS_BASH environment
::#
%dk_call% dk_validate DKIMPORTS_DIR "%dk_call% dk_DKIMPORTS_DIR"
%dk_call% dk_validate MSYS2 "%dk_call% %DKIMPORTS_DIR%\msys2\dk_install.cmd"
set "PATH=%MSYS2%\usr\bin;%PATH%"
cd %MSYS2%

%dk_call% dk_clearScreen
%dk_call% dk_title "Digitalknob DK_MSYS_BASH"
%dk_call% dk_info "############ DK_MSYS_BASH environment ############"
%dk_call% dk_info ""
%MSYS2%/usr/bin/env MSYSTEM=MSYS /usr/bin/bash