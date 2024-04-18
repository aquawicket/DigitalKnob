@echo off

::###### Load Function files ######
call "../functions/DK.cmd"

echo **** GLOBAL VARIABLES ***
echo DKBATCH_DIR = %DKBATCH_DIR%
echo SCRIPT_PATH = %SCRIPT_PATH%
echo SCRIPT_DIR = %SCRIPT_DIR%
echo SCRIPT_NAME = %SCRIPT_NAME%

:: dk_cmake_eval(<cmake_commands;.;.;> <return_variables;.;.;.> <-DVARS;.;.;>)
call dk_cmake_eval "dk_debug('sent with dk_cmake_eval')"

pause