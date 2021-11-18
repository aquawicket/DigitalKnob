:: CMakeScript Tester
@ECHO off

set "CMAKE=C:\Program Files (x86)\CMake\bin\cmake.exe"
set "Test_cmake=C:\Users\%USERNAME%\digitalknob\DK\DKCMake\other\Test.cmake"
set "WORKING_PATH=C:\Users\%USERNAME%\digitalknob"
"%CMAKE%" -P %Test_cmake%
pause