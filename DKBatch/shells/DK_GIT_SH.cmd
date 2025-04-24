@echo off
if not defined DKBATCH_FUNCTIONS_DIR_ set "DKBATCH_FUNCTIONS_DIR_=%CD:\=/%/../functions/"
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)

::################################################################################
::# GIT_BASH environment
::#
%dk_call% dk_validate GIT "%dk_call% dk_installGit"

%dk_call% dk_clearScreen
%dk_call% dk_title "Digitalknob DK_GIT_BASH"
%dk_call% dk_info "############ DK_GIT_BASH environment ############"
%dk_call% dk_info ""
%GIT%/bin/bash
