@echo off

if "%~1" neq "1" (
	start cmd /k %~f0 1
	exit
)




::###############################
:main
	echo main()
	
	call :func1
	echo func1_exit_code = %errorlevel%
	
	call :func2
	echo func2_exit_code = %errorlevel%
	
	echo.
	echo main()_exit
	pause
goto:eof
exit /b 0


::##############################
:func1
	echo func1 exits with goto:eof
	
cmd /c exit /b 1
goto:eof


::##############################
:func2
	echo func2 exits with exit /b 0
	
exit /b 2



