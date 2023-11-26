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

::%DKBATCH%
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::    %ERROR%  message
:: %IF_ERROR%  message
::    %FATAL%  message
:: %IF_FATAL%  message
::
::
::    %ERROR%: Throw an error message, then continue script
:: %IF_ERROR%: Throw an error message if %ERRORLEVEL% is not 0, then continue script
::    %FATAL%: Throw an error message, then exit script
:: %IF_FATAL%: Throw an error messate if %ERRORLEVEL% is not 0, then exit script
::
::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
set ERROR_CODE=%ERRORLEVEL%
if "%~1"=="IF_ERROR" (goto :IF_ERROR)
if "%~1"=="ERROR" (goto :ERROR)
if "%~1"=="IF_FATAL" (goto :IF_FATAL)
if "%~1"=="FATAL" (goto :FATAL)

:IF_ERROR
if not "%ERROR_CODE%"=="0" (
	echo [91m ERROR: %ERROR_CODE%   %3 [0m
	call :print_error %*
	pause
	exit /b %ERROR_CODE%
)
goto :eof

:ERROR
echo [91m ERROR: %ERROR_CODE%   %3 [0m
call :print_error %*
pause
exit /b %ERROR_CODE%



:IF_FATAL
if not "%ERROR_CODE%"=="0" (
	echo [31m FATAL: %ERROR_CODE%   %3 [0m
	call :print_error %*
	echo Press any key to exit . . .
	pause >nul
	exit %ERROR_CODE%
)
goto :eof

:FATAL
echo [31m FATAL: %ERROR_CODE%   %3 [0m
call :print_error %*
echo Press any key to exit . . .
pause >nul
exit %ERROR_CODE%


:print_error
for /f "delims=:" %%a in ('findstr /n /c:"%~3" "%~f2"') do set "line=%%a"
echo [91m  File: %~f2: !line! [0m
set /A n=1
set /A min=!line!-6
set /A max=!line!+6
for /f "delims=" %%a in ('findstr /n /r /c:"^" "%~f2"') do (
	if !n! LSS !max! (
		if !n! GTR !min! (
			set str=%%a
			set str=!str::=:	! 
			if !n! EQU !line! (
				echo [30;41m^>  !str![0m
			) else (
				echo    !str!
			)
		)
	)		
	set /a n+=1
)
echo.
echo.
goto :eof
