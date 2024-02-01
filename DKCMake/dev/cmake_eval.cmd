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
setlocal EnableDelayedExpansion
if not defined in_subprocess (cmd /k set in_subprocess=y ^& %0 %*) & exit ) :: keep window open
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: cmake_eval eval_code error
::
:: Func:  Run code within th DKCMake codebase
::
:: eval_code:  the code to send to CMake
:: error:    the error code if any
::
:: Example:  call cmake_eval dk_info("called from cmake_eval")
::           echo cmake_eval returned: %error%
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

::###### cmake_eval ######
:cmake_eval
	if [%1] == [] 				echo "ERROR: cmake_eval() parameter1 is invalid" & goto:eof
	
	set "DKBRANCH=Development"
	set "DIGITALKNOB=%HOMEDRIVE%%HOMEPATH%\digitalknob"
	set "DKCMAKE=%DIGITALKNOB%\%DKBRANCH%\DKCMake"
	
	if exist "C:\Program Files\CMake\bin\cmake.exe" 		set "CMAKE=C:\Program Files\CMake\bin\cmake.exe"
	if exist "C:\Program Files (x86)\CMake\bin\cmake.exe" 	set "CMAKE=C:\Program Files (x86)\CMake\bin\cmake.exe"
	if not exist "%CMAKE%" 									echo "ERROR: Could not locate CMAKE" & goto:eof
	
	if not exist "%CMAKE%"		echo "ERROR: Could not locate CMAKE" 	& goto:eof
	if not exist "%DKCMAKE%" 	echo "ERROR: Could not locate DKCMAKE" 	& goto:eof

	:: cmake_eval begin
	set commands=%1
	set variables=%2
	call set commands=%%commands:"=%%
	set "DKCOMMAND=%commands%"
	call set DKCOMMAND=%%DKCOMMAND:^\=^/%%
	echo DKCOMMAND = %DKCOMMAND%
	call set DKCMAKE_DIR=%%DKCMAKE:^\=^/%%
	
	::echo "%CMAKE%" "-DDKCMAKE=%DKCMAKE%" "-DDKCOMMAND=%DKCOMMAND%" -P "%DKCMAKE%/dev/cmake_eval.cmake" --log-level=TRACE >cmake_eval.out 2>cmake_eval.err
	
	if [%2] == [] goto no_return_values
	goto with_return_values
	
	:no_return_values
		"%CMAKE%" "-DDKCMAKE=%DKCMAKE_DIR%" "-DDKCOMMAND=%DKCOMMAND%" -P "%DKCMAKE_DIR%/dev/cmake_eval.cmake"
		goto:eof
		
	:with_return_values
		"%CMAKE%" "-DDKCMAKE=%DKCMAKE_DIR%" "-DDKCOMMAND=%DKCOMMAND%" "-DDKRETURN=%~2" -P %DKCMAKE_DIR%/dev/cmake_eval.cmake
		if not exist %DKCMAKE%/cmake_vars.cmd goto:eof
		call %DKCMAKE%\cmake_vars.cmd
		del %DKCMAKE%\cmake_vars.cmd
		
	::echo return code: %ERRORLEVEL%
	
	:::: work with cmake return code files ::::
	:: std::out
	set out=
	if exist "cmake_eval.out" (
		for /f "Tokens=* Delims=" %%x in (cmake_eval.out) do (
			set out=!out!%%x
			echo %%x
		)
	)
	::out contains all of the lines
	::del cmake_eval.out
	::echo %out%	
			
	:: std::err
	set err=
	if exist "cmake_eval.err" (
		for /f "Tokens=* Delims=" %%x in (cmake_eval.err) do (
			set err=!err!%%x
			echo [91m %%x [0m
		)
	)
	::del cmake_eval.out
	::err contains all of the lines
	::echo %err%
goto:eof
