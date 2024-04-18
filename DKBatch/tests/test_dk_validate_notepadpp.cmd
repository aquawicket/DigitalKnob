@echo off

::###### Load Function files ######
call "../functions/DK.cmd"

echo **** GLOBAL VARIABLES ***
echo DKBATCH_DIR = %DKBATCH_DIR%
echo SCRIPT_PATH = %SCRIPT_PATH%
echo SCRIPT_DIR = %SCRIPT_DIR%
echo SCRIPT_NAME = %SCRIPT_NAME%

call dk_validate_notepadpp

pause