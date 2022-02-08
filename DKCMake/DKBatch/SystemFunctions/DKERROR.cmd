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
if "%1"=="IF_ERROR" (goto :IF_ERROR)
if "%1"=="ERROR" (goto :ERROR)
if "%1"=="IF_FATAL" (goto :IF_FATAL)
if "%1"=="FATAL" (goto :FATAL)

:IF_ERROR
if not "%ERRORLEVEL%"=="0" (
	for /f "delims=:" %%a in ('findstr /n /c:"%~3" "%~f2"') do set "line=%%a"
	echo.
	echo.
	echo [91m IF_ERROR: %ERRORLEVEL% - %3 [0m
	echo [91m  File: %~f2: !line! [0m
	set /A n = 1
	set /A min = !line!-6
	set /A max = !line!+6
	for /f "delims=" %%a in ('findstr /n "^" "%~f2"') do (
		if !n! lss !max! (
			if !n! gtr !min! (
				set "string=%%a"
				if !n! equ !line! (
					echo [30;41m^>	!n!:	!string:~2,-1%![0m
				) else (
					echo		!n!:	!string:~2,-1%!
				)
			)
		)		
		set /a n+=1
	)
	echo.
	echo.
	exit /b %ERRORLEVEL%
)
goto :EOF

:IF_FATAL
if not "%ERRORLEVEL%"=="0" (
	for /f "delims=:" %%a in ('findstr /n /c:"%~3" "%~f2"') do set "line=%%a"
	echo.
	echo.
	echo [31m IF_FATAL: %ERRORLEVEL% - %3 [0m
	echo [31m  File: %~f2:!line! [0m
	set /A n = 1
	set /A min = !line!-6
	set /A max = !line!+6
	for /f "delims=" %%a in ('findstr /n "^" "%~f2"') do (
		if !n! lss !max! (
			if !n! gtr !min! (
				set "string=%%a"
				if !n! equ !line! (
					echo [30;41m^>	!n!:	!string:~2,-1%![0m
				) else (
					echo		!n!:	!string:~2,-1%!
				)
			)
		)		
		set /a n+=1
	)
	echo.
	echo.
	echo Press any key to exit . . .
	pause >nul
	exit %ERRORLEVEL%
)
goto :EOF

:ERROR
for /f "delims=:" %%a in ('findstr /n /c:"%~3" "%~f2"') do set "line=%%a"
echo.
echo.
echo [91m ERROR: %ERRORLEVEL% - %3 [0m
echo [91m  File: %~f2:!line! [0m
set /A n = 1
set /A min = !line!-6
set /A max = !line!+6
for /f "delims=" %%a in ('findstr /n "^" "%~f2"') do (
	if !n! lss !max! (
		if !n! gtr !min! (
			set "string=%%a"
			if !n! equ !line! (
				echo [30;41m^>	!n!:	!string:~2,-1%![0m
			) else (
				echo		!n!:	!string:~2,-1%!
			)
		)
	)		
	set /a n+=1
)
echo.
echo.
exit /b %ERRORLEVEL%

:FATAL
for /f "delims=:" %%a in ('findstr /n /c:"%~3" "%~f2"') do set "line=%%a"
echo.
echo.
echo [31m FATAL: %ERRORLEVEL% - %3 [0m
echo [31m  File: %~f2:!line! [0m
set /A n = 1
set /A min = !line!-6
set /A max = !line!+6
for /f "delims=" %%a in ('findstr /n "^" "%~f2"') do (
	if !n! lss !max! (
		if !n! gtr !min! (
			set "string=%%a"
			if !n! equ !line! (
				echo [30;41m^>	!n!:	!string:~2,-1%![0m
			) else (
				echo		!n!:	!string:~2,-1%!
			)
		)
	)		
	set /a n+=1
)
echo.
echo.
exit /b %ERRORLEVEL%
