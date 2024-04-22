@echo off
::cls
echo %~0(%*)
if "%*" NEQ "" call %* 


:::::: DK_INIT ::::::
call "DKBatch/functions/DK.cmd"


:::::: Global variables ::::::
echo SCRIPT_PATH = %SCRIPT_PATH%
echo DKBATCH_DIR = %DKBATCH_DIR%


:::::: Load Main Program ::::::
dk_buildMain %*