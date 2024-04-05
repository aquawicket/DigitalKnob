@echo off
cls
echo %0(%*)

:::::: Load DK Function files (DK_INIT) ::::::
call functions/DK.cmd

:::::: Load Main Program ::::::
::if "%*" NEQ "" call %* 
dk_build_main "%*"