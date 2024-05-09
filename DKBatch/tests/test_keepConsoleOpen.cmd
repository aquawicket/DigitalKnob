@echo off

::####################################################################
::# test_dk_keepConsoleOpen.cmd
::#
::#
::###### DK_Init ######
call functions/DK.cmd

call dk_keepConsoleOpen

:::::: Load Main Program ::::::
::if "%*" neq "" call %* 
::myfunc "mydata"