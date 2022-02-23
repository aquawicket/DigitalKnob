set "STAY_OPEN=1"
%dkbatch%


set "DIGITALKNOB=C:\Users\%USERNAME%\digitalknob"
set "DKCMAKE=%DIGITALKNOB%\DK\DKCMake"
if exist "C:\Program Files\CMake\bin\cmake.exe" set "CMAKE=C:\Program Files\CMake\bin\cmake.exe"
if exist "C:\Program Files (x86)\CMake\bin\cmake.exe" set "CMAKE=C:\Program Files (x86)\CMake\bin\cmake.exe"
if not exist %CMAKE% ( ERROR "Could not locate CMAKE" )

:begin
cls

set "file=%DKCMAKE%\dev\test.cmake"
"%CMAKE%" -P "%file%" 
 
pause
goto :begin 
 
%DKEND% 
