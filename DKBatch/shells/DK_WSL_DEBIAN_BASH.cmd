@echo off&::###### DK.cmd #########################################################################################################################
if NOT EXIST "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if NOT defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


::################################################################################
::# DK_WSL_DEBIAN_BASH environment
::#
%dk_call% dk_depend wsl-debian

%dk_call% dk_clearScreen
%dk_call% dk_title "Digitalknob DK_WSL_DEBIAN_BASH"
%dk_call% dk_info "############ DK_WSL_DEBIAN_BASH environment ############"
%dk_call% dk_info ""
%dk_call% dk_validate WSL_EXE "%dk_call% dk_WSL_EXE"
::%WSL_EXE% -d DEBIAN -e bash -li -c "exec bash"
%WSL_EXE% -d DEBIAN -e bash -li

