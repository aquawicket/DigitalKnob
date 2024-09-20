@echo off

set "printVars=echo main = %main% & echo func1 = %func1% & echo func2 = %func2% & echo func3 = %func3%"
set /a "indent=0"

echo ######### SCOPE TEST ############

:main
 setlocal
	echo:
	echo -^> main
	
	set "main=main"
	
	echo main = %main% & echo func1 = %func1% & echo func2 = %func2% & echo func3 = %func3%
	call :func1
	echo main = %main% & echo func1 = %func1% & echo func2 = %func2% & echo func3 = %func3%
	call :func2
	echo main = %main% & echo func1 = %func1% & echo func2 = %func2% & echo func3 = %func3%
	call :func3
	echo main = %main% & echo func1 = %func1% & echo func2 = %func2% & echo func3 = %func3%
	
	echo ^<- main
	echo:
goto:eof


:func1
 setlocal
	echo:
	echo ----^> func1

	set "func1=func1"
	
	echo main = %main% & echo func1 = %func1% & echo func2 = %func2% & echo func3 = %func3%
	call :func2
	echo main = %main% & echo func1 = %func1% & echo func2 = %func2% & echo func3 = %func3%
	
	echo ^<---- func1
	echo:
goto:eof


:func2
 setlocal
	echo:
	echo --------^> func2

	set "func2=func2"
	
	echo main = %main% & echo func1 = %func1% & echo func2 = %func2% & echo func3 = %func3%
	call :func3
	echo main = %main% & echo func1 = %func1% & echo func2 = %func2% & echo func3 = %func3%
	
	echo ^<-------- func2
	echo:
goto:eof


:func3
 setlocal
	echo:
	echo ------------^> func3

	set "func3=func3"
	echo main = %main% & echo func1 = %func1% & echo func2 = %func2% & echo func3 = %func3%
	
	echo ^<------------ func3
	echo:
goto:eof