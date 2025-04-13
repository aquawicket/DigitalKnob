@echo off
if not defined DKBATCH_FUNCTIONS_DIR_ set "DKBATCH_FUNCTIONS_DIR_=%CD:\=/%/../functions/"
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%A IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpA")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)

::################################################################################
::# CMD environment
::#





%dk_call% dk_clearScreen
%dk_call% dk_title "Digitalknob DK.cmd"
%dk_call% dk_echo "############ DK.cmd environment ############"
%dk_call% dk_echo ""

