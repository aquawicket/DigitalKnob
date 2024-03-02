@echo off
if not defined in_subprocess (cmd /k set in_subprocess=y ^& %0 %*) & exit ) :: keep window open


set "DKCMAKE_DIR=C:/Users/%USERNAME%/digitalknob/Development/DKCMake"
if exist "C:/Program Files/CMake/bin/cmake.exe" set "CMAKE_EXE=C:/Program Files/CMake/bin/cmake.exe"
if exist "C:/Program Files (x86)/CMake/bin/cmake.exe" set "CMAKE_EXE=C:/Program Files (x86)/CMake/bin/cmake.exe"
::echo CMAKE_EXE = %CMAKE_EXE%"


"%CMAKE_EXE%" "-DDKCMAKE_DIR=%DKCMAKE_DIR%" -P "%DKCMAKE_DIR%/dev/Test.cmake"
