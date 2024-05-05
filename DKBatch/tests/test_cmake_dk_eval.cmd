@echo off

::####################################################################
::# test_cmake_dk_eval.cmd
::#
::#
::###### DK_Init ######
call ../functions/DK.cmd
::call dk_keepConsoleOpen
echo "%DKSCRIPT_PATH%"
echo %0


call dk_cmakeEval "dk_debug('dk_cmakeEval with no return and no variables')"
call dk_pause

call dk_cmakeEval "dk_debug('dk_cmakeEval with return variables')" "CMAKE_CURRENT_LIST_DIR;CMAKE_SOURCE_DIR"
call dk_printVar CMAKE_SOURCE_DIR
call dk_printVar CMAKE_CURRENT_LIST_DIR
call dk_pause

call dk_cmakeEval "dk_debug('dk_cmakeEval with return variables and input variables')" "CMAKE_CURRENT_LIST_DIR;CMAKE_SOURCE_DIR;TEST" "-DTEST=test"
call dk_printVar CMAKE_SOURCE_DIR
call dk_printVar CMAKE_CURRENT_LIST_DIR
call dk_printVar TEST
call dk_pause