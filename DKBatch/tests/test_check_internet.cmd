@echo off

::####################################################################
::# test_check_internet()
::#
::#

:: Create temporary batch file
echo @ECHO OFF> reply.cmd
echo set connect=1>>reply.cmd
echo Checking connection, please wait...
echo @ECHO OFF> check_net.cmd
ping 194.109.6.66 | find "Reply from " >>check_net.cmd
:: Set "default" value, which may or may not be altered by check_net.cmd
set connect=0
call check_net.cmd
del check_net.cmd
del reply.cmd
if "%connect%" equ "0" echo You have NO active connection to the internet
if "%connect%" equ "1" echo You have an active connection to the internet