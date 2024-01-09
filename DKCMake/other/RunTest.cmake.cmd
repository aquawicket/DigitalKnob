:: This source file is part of digitalknob, the cross-platform C/C++/Javascript/Html/Css Solution
::
:: For the latest information, see https://github.com/aquawicket/DigitalKnob
::
:: Copyright(c) 2010 - 2023 Digitalknob Team, and contributors
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
@ECHO off

set "CMAKE_DL=https://github.com/Kitware/CMake/releases/download/v3.21.1/cmake-3.21.1-windows-i386.msi"
set "GIT_DL=https://github.com/git-for-windows/git/releases/download/v2.30.1.windows.1/Git-2.30.1-32-bit.exe"
set "DIGITALKNOB=C:/Users/%USERNAME%/digitalknob"
set "DKCMAKE=%DIGITALKNOB%/Development/DKCMake"
if exist "C:/Program Files/CMake/bin/cmake.exe" set "CMAKE=C:/Program Files/CMake/bin/cmake.exe"
if exist "C:/Program Files (x86)/CMake/bin/cmake.exe" set "CMAKE=C:/Program Files (x86)/CMake/bin/cmake.exe"
if not exist %CMAKE% ( ERROR "Could not locate CMAKE" )

:begin
cls

set "file=%DKCMAKE%/other/Test.cmake"
"%CMAKE%" -DDKCMAKE=%DKCMAKE% -P "%file%" 
 
pause 
%DKEND% 
