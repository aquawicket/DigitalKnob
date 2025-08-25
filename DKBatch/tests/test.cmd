@echo off

REM Creating a Newline variable (the two blank lines are required!)
set NL=^


set \n=^^^%NL%%NL%^%NL%%NL%




REM Example Usage:
echo A There should be a newline%\n%inserted here > testA.txt
echo B There should be a newline^%NL%%NL%inserted here > testB.txt
echo C There should be a newline"%NL%"inserted here > testC.txt
pause
set messageB=B There should be a newline^^^%NL%%NL%^%NL%%NL%inserted here
::echo %messageB% >> test.txt

set "messageC=C There should be a newline\ninserted here"
setlocal enableDelayedExpansion
echo !messageC:\n=%\n%!
endlocal

set "messageD=D There should be a newline\ninserted here"
setlocal enableDelayedExpansion
set messageD=!messageD:\n=^^^%NL%%NL%^%NL%%NL%!
echo %messageD%
endlocal 

set "messageE=E There should be a newline\ninserted here"
::call set messageE=%%messageE:\n=^^^%NL%%NL%^%NL%%NL%%%
::call echo %%messageE:\n=%\n%%% > testC.txt



::for /f "delims=" %%G in ("C There should be a newline^^^%NL%%NL%^%NL%%NL%inserted here") do (echo %%G)


pause