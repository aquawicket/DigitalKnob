:: CMakeScript Tester
@ECHO off

set "CMAKE_DL=https://github.com/Kitware/CMake/releases/download/v3.21.1/cmake-3.21.1-windows-i386.msi"
set "GIT_DL=https://github.com/git-for-windows/git/releases/download/v2.30.1.windows.1/Git-2.30.1-32-bit.exe"
set "DIGITALKNOB=C:\Users\%USERNAME%\digitalknob"
set "DKPATH=%DIGITALKNOB%\DK"
set "DKDOWNLOAD=%DIGITALKNOB%\Download"

if exist "C:\Program Files\CMake\bin\cmake.exe" set "CMAKE=C:\Program Files\CMake\bin\cmake.exe"
if exist "C:\Program Files (x86)\CMake\bin\cmake.exe" set "CMAKE=C:\Program Files (x86)\CMake\bin\cmake.exe"
if NOT exist "%CMAKE%" (
    echo "cannot find cmake, please update the repository"
)

set "Test_cmake=C:\Users\%USERNAME%\digitalknob\DK\DKCMake\other\Test.cmake"
if NOT exist "%Test_cmake%" (
	echo "cannot find Test.cmake file, please update the repository"
)

"%CMAKE%" -P %Test_cmake%

:end
ECHO Done
pause
