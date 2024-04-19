@echo off
cls
echo %0(%*)

:::::: Load DK Function files (DK_INIT) ::::::
call functions/DK.cmd

call dk_keep_console_open

:::::: Load Main Program ::::::
::if "%*" NEQ "" call %* 
::myfunc "mydata"