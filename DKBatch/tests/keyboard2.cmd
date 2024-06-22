@echo off
setlocal EnableDelayedExpansion

rem Create an empty file
cd . > key.txt

rem Start a parallel process that wait for Enter key
rem and add a line to the empty file
start "" /B cmd /C "set /P = & echo line >> key.txt"

set "key="
:wait
   cls
   set "number=%random:~-4%"
   echo %number%
   echo/
   echo Press Enter key to stop the numbers...
   set /P key=< key.txt
if not defined key goto wait

echo The last number is: %number%