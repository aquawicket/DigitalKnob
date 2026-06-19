:: This source file is part of DigitalKnob, the cross-platform C/C++/Javascript/Html/Css Solution
::
:: For the latest information, see https://github.com/aquawicket/DigitalKnob
::
:: Copyright(c) 2010 - 2025 Digitalknob Team, and contributors
::
:: Permission is hereby granted, free of charge, to any person obtaining a copy
:: of this software and associated documentation files(the "Software"), to deal
:: in the Software without restriction, including without limitation the rights
:: to use, copy, modify, merge, publish, distribute, sublicense, and /or sell
:: copies of the Software, and to permit persons to whom the Software is
:: furnished to do so, subject to the following conditions :
::
:: The above copyright notice and this permission notice shall be included in all
:: copies or substantial portions of the Software.
::
:: THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
:: IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
:: FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
:: AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
:: LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
:: OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
:: SOFTWARE.

:: CMakeScript Tester
@echo off

set "cmake_Import=https://github.com/Kitware/CMake/releases/download/v3.21.1/cmake-3.21.1-windows-i386.msi"
set "GIT_DL=https://github.com/git-for-windows/git/releases/download/v2.30.1.windows.1/Git-2.30.1-32-bit.exe"
set "DIGITALKNOB_DIR=%USERPROFILE%\Digital Knob"
set "DKCMAKE_DIR=%DIGITALKNOB_DIR%/Development/DKCMake"
if EXIST "%ProgramFiles:\=/%/CMake/bin/cmake.exe" set "cmake.exe=%ProgramFiles:\=/%/CMake/bin/cmake.exe"
if EXIST "%ProgramFiles(x86):\=/%/CMake/bin/cmake.exe" set "cmake.exe=%ProgramFiles(x86):\=/%/CMake/bin/cmake.exe"
if NOT EXIST "%cmake.exe%" ( ERROR "Could NOT locate cmake.exe" )

:begin
cls

set "file=%DKCMAKE_DIR%/other/Test.cmake"
"%cmake.exe%" -DDKCMAKE_DIR=%DKCMAKE_DIR% -P "%file%"

pause
