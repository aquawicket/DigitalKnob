@echo off
cls
echo %0(%*)

:::::: Load DK Function files (DK_INIT) ::::::
call functions/DK.cmd

call dk_keepConsoleOpen

:::::: Load Main Program ::::::
::if "%*" NEQ "" call %* 
::myfunc "mydata"