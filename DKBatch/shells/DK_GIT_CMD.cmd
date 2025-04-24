@echo off
if not defined DKBATCH_FUNCTIONS_DIR_ set "DKBATCH_FUNCTIONS_DIR_=%CD:\=/%/../functions/"
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)

::################################################################################
::# GIT_CMD environment
::#
%dk_call% dk_validate GIT "%dk_call% dk_installGit"
set "PATH=%GIT%\cmd;%PATH%"
%dk_call% dk_validate DKBRANCH_DIR "%dk_call% dk_DKBRANCH_DIR"
%dk_call% dk_chdir %DKBRANCH_DIR%


%dk_call% dk_clearScreen
%dk_call% dk_title "Digitalknob DK_GIT_CMD"
%dk_call% dk_echo "############ DK_GIT_CMD environment ############"
%dk_call% dk_echo ""
