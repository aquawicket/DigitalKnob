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
