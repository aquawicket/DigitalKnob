@echo off

echo one | ( set /p varX= & set varX )
set var1=var2
set var2=content of two
echo one | ( echo %%%var1%%% )
echo three | echo MYCMDLINE %%cmdcmdline%%
echo four  | (cmd /v:on /c  echo 4: !var2!)

pause