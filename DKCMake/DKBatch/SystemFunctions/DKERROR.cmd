%DKBATCH%
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::%ERROR% message
::
:: Func:  Throw and error with a message and halt further batch execution
::
:: message:  The message to display with the error
::
:: Example:   if not exist "somefile.txt" (
::				  %ERROR% "File not found"
::		      )
::            prints: ERROR:0 "File not found"
::                     File: C:\path\to\file\that\threw\the\error.bat
::
::           
:: Example 2: if not "%ERRORLEVEL%"=="0" (
::				  %ERROR% "The Last Command Failed"
::            )
::            prints: ERROR:18 "The Last Command Failed"
::                     File: C:\path\to\file\that\threw\the\error.bat
::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
if "%1"=="IF_ERROR" (goto :IF_ERROR)
if "%1"=="ERROR" (goto :ERROR)
if "%1"=="IF_FATAL" (goto :IF_FATAL)

:IF_ERROR
if not "%ERRORLEVEL%"=="0" (
	echo [91m ERROR:%ERRORLEVEL% - %3 [0m
	echo [91m  File: %~f2 [0m
	exit /b %ERRORLEVEL%
)
goto :EOF

:IF_FATAL
if not "%ERRORLEVEL%"=="0" (
	echo [91m ERROR:%ERRORLEVEL% - %3 [0m
	echo [91m  File: %~f2 [0m
	pause
	exit %ERRORLEVEL%
)
goto :EOF

:ERROR
echo [91m ERROR:%ERRORLEVEL% - %3 [0m
echo [91m  File: %~f2 [0m
exit /b %ERRORLEVEL%
