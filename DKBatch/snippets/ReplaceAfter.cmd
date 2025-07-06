@echo off

set str=C:/Windows/System32/myFile.cmd.old
echo str = %str%
echo removing everything after .
call echo %%str:.%str:*.=%=%%

pause