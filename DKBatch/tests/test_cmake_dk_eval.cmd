@echo off

::###### Load Function files ######
call ../functions/DK.cmd
::dk_keepConsoleOpen
echo "%SCRIPT_PATH%"
echo %0
::if not defined in_subprocess (cmd /k set in_subprocess=y ^& %0 %*) & exit )	

:: dk_cmakeEval(<cmake_commands;.;.;> <return_variables;.;.;.> <-DVARS;.;.;>)
call dk_cmakeEval "dk_debug('dk_cmakeEval with no return and no variables')"
pause

call dk_cmakeEval "dk_debug('dk_cmakeEval with return variables')" "CMAKE_CURRENT_LIST_DIR;CMAKE_SOURCE_DIR"
call dk_debug CMAKE_SOURCE_DIR
call dk_debug CMAKE_CURRENT_LIST_DIR
pause

call dk_cmakeEval "dk_debug('dk_cmakeEval with return variables and input variables')" "CMAKE_CURRENT_LIST_DIR;CMAKE_SOURCE_DIR;TEST" "-DTEST=test"
call dk_debug CMAKE_SOURCE_DIR
call dk_debug CMAKE_CURRENT_LIST_DIR
call dk_debug TEST
pause