@echo off
if not defined in_subprocess (cmd /k set in_subprocess=y ^& %0 %*) & exit ) :: keep window open


set "DKCMAKE=C:/Users/%USERNAME%/digitalknob/Development/DKCMake"
if exist "C:/Program Files/CMake/bin/cmake.exe" set "CMAKE=C:/Program Files/CMake/bin/cmake.exe"
if exist "C:/Program Files (x86)/CMake/bin/cmake.exe" set "CMAKE=C:/Program Files (x86)/CMake/bin/cmake.exe"
::echo CMAKE = %CMAKE%"


"%CMAKE%" "-DDKCMAKE=%DKCMAKE%" -P "%DKCMAKE%/dev/Test.cmake"
