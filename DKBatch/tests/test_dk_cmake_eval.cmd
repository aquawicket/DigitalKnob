@echo off
	
::###### Load Function files ######
call "../functions/DK.cmd"

:: dk_cmake_eval(<cmake_commands;.;.;> <return_variables;.;.;.> <-DVARS;.;.;>)
call dk_cmake_eval "dk_debug('dk_cmake_eval with no return and no variables')"


call dk_cmake_eval "dk_debug('dk_cmake_eval with return variables')" "CMAKE_CURRENT_LIST_DIR;CMAKE_SOURCE_DIR"
call dk_debug CMAKE_SOURCE_DIR
call dk_debug CMAKE_CURRENT_LIST_DIR


call dk_cmake_eval "dk_debug('dk_cmake_eval with return variables and input variables')" "CMAKE_CURRENT_LIST_DIR;CMAKE_SOURCE_DIR;TEST" "-DTEST=test"
call dk_debug CMAKE_SOURCE_DIR
call dk_debug CMAKE_CURRENT_LIST_DIR
call dk_debug TEST
pause