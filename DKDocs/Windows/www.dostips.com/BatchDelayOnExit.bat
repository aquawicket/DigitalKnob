@ECHO OFF
REM.-- Prepare the Command Processor
SETLOCAL ENABLEEXTENSIONS
SETLOCAL ENABLEDELAYEDEXPANSION

REM.-- Version History --
REM         XX.XXX           YYYYMMDD Author Description
SET version=01.000-beta &rem 20051201 p.h.  initial version, providing the framework
REM !! For a new version entry, copy the last entry down and modify Date, Author and Description
SET version=%version: =%

REM.-- Set the window title 
SET title=%~n0


REM.-- your code goes here
echo.Hello World


REM.-- End of application
FOR /l %%a in (5,-1,1) do (TITLE %title% -- closing in %%as&ping -n 2 -w 1 127.0.0.1>NUL)
TITLE Press any key to close the application&ECHO.&GOTO:EOF