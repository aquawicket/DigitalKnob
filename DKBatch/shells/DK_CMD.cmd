@echo off
if not exist "%DKBATCH_FUNCTIONS_DIR_%" set "DKBATCH_FUNCTIONS_DIR_=%CD:\=/%/../functions/"
if not defined DK_CMD (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)

::################################################################################
::# CMD environment
::#





%dk_call% dk_clearScreen
%dk_call% dk_title "Digitalknob DK_CMD"
%dk_call% dk_echo "############ DK_CMD environment ############"
%dk_call% dk_echo ""

