::dk_includeGuard()

::~1 = ERROR
::~3 = C:\Users\aquawicket\digitalknob\Development\DKBatch\System\test_ERROR.cmd
::~3 = FATAL: This throws an error, and exits the program

::################################################################################
::# dk_printError(<LVL> <filepath> <message>)
::#
::#
::#
:dk_printError
	::call dk_debugFunc
	setlocal enableDelayedExpansion
	::echo ~0 = %~0
	::echo ~1 = %~1
	::echo ~3 = %~2
	::echo ~3 = %~3
	echo.
	for /f "delims=:" %%a in ('findstr /n /c:"%~3" "%~f2"') do set "line=%%a"
	echo [91m  File: %~f2: !line! [0m
	set /A n=1
	set /A min=!line!-15
	set /A max=!line!+15
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