@echo off

::###### Load Function files ######
call "../functions/DK.cmd"

echo **** GLOBAL VARIABLES ***
echo DKBATCH_DIR = %DKBATCH_DIR%
echo SCRIPT_PATH = %SCRIPT_PATH%
echo SCRIPT_DIR = %SCRIPT_DIR%
echo SCRIPT_NAME = %SCRIPT_NAME%

echo "This is a normal echo commmand"
call dk_echo "This is a dk_echo line"
call dk_echo "%cyan% This is dk_echo with color %clr%"

pause