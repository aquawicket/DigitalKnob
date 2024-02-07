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
@echo off
if not defined in_subprocess (cmd /k set in_subprocess=y ^& %0 %*) & exit ) :: keep window open
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: cmake_echo <command> <file.ext>
::
:: Func:  Run code within th DKCMake codebase
::
:: eval_code:  the code to send to CMake
:: error:    the error code if any
::
:: Example:  call cmake_echo dk_info("called from cmake_echo")
::           echo cmake_echo returned: %error%
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

::###### cmake_echo ######
:cmake_echo
	if [%1] == []  goto:eof
	
	set "DKBRANCH=Development"
	set "DIGITALKNOB=%HOMEDRIVE%%HOMEPATH%\digitalknob"
	set "DKCMAKE=%DIGITALKNOB%\%DKBRANCH%\DKCMake"
	if exist "C:\Program Files\CMake\bin\cmake.exe" 		set "CMAKE=C:\Program Files\CMake\bin\cmake.exe"
	if exist "C:\Program Files (x86)\CMake\bin\cmake.exe" 	set "CMAKE=C:\Program Files (x86)\CMake\bin\cmake.exe"
	if not exist "%CMAKE%" 									echo "ERROR: Could not locate CMAKE" & goto:eof
	if not exist "%CMAKE%"		echo "ERROR: Could not locate CMAKE" 	& goto:eof
	if not exist "%DKCMAKE%" 	echo "ERROR: Could not locate DKCMAKE" 	& goto:eof

	call set DKCMAKE_DIR=%%DKCMAKE:^\=^/%%
	
	"%CMAKE%" %* -P "%DKCMAKE_DIR%/dev/cmake_echo.cmake"

	::echo return code: %ERRORLEVEL%
goto:eof