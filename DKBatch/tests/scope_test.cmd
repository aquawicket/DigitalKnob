@echo off
echo -^> root

set "globalVar=ROOT"
echo globalVar = %globalVar% & echo main = %main% & echo func1 = %func1% & echo func2 = %func2% & echo func3 = %func3%
call :main
set /a "indent=0"

echo ^<- root
echo ######### SCOPE TEST ############

:main
set "globalVar=MAIN"
 setlocal
	echo:
	echo -^> main
	
	set "main=main"
	set "func3=UNDEFINED"
	
	echo globalVar = %globalVar% & echo main = %main% & echo func1 = %func1% & echo func2 = %func2% & echo func3 = %func3%
	call :func1
	echo globalVar = %globalVar% & echo main = %main% & echo func1 = %func1% & echo func2 = %func2% & echo func3 = %func3%
	call :func2
	echo globalVar = %globalVar% & echo main = %main% & echo func1 = %func1% & echo func2 = %func2% & echo func3 = %func3%
	call :func3
	echo globalVar = %globalVar% & echo main = %main% & echo func1 = %func1% & echo func2 = %func2% & echo func3 = %func3%
	
	echo ^<- main
	echo:
goto:eof


:func1
set "globalVar=FUNC1"
 setlocal
	echo:
	echo ----^> func1

	set "func1=func1"
	
	echo globalVar = %globalVar% & echo main = %main% & echo func1 = %func1% & echo func2 = %func2% & echo func3 = %func3%
	call :func2
	echo globalVar = %globalVar% & echo main = %main% & echo func1 = %func1% & echo func2 = %func2% & echo func3 = %func3%
	
	echo ^<---- func1
	echo:
goto:eof


:func2
set "globalVar=FUNC2"
 setlocal
	echo:
	echo --------^> func2

	set "func2=func2"
	
	echo globalVar = %globalVar% & echo main = %main% & echo func1 = %func1% & echo func2 = %func2% & echo func3 = %func3%
	call :func3
	echo globalVar = %globalVar% & echo main = %main% & echo func1 = %func1% & echo func2 = %func2% & echo func3 = %func3%
	
	echo ^<-------- func2
	echo:
goto:eof


:func3
set "globalVar=FUNC3"
 setlocal
	echo:
	echo ------------^> func3

	set "func3=func3"
	echo globalVar = %globalVar% & echo main = %main% & echo func1 = %func1% & echo func2 = %func2% & echo func3 = %func3%
	endlocal
	echo globalVar = %globalVar% & echo main = %main% & echo func1 = %func1% & echo func2 = %func2% & echo func3 = %func3%
	endlocal
	echo globalVar = %globalVar% & echo main = %main% & echo func1 = %func1% & echo func2 = %func2% & echo func3 = %func3%
	endlocal
	echo globalVar = %globalVar% & echo main = %main% & echo func1 = %func1% & echo func2 = %func2% & echo func3 = %func3%
	endlocal
	echo globalVar = %globalVar% & echo main = %main% & echo func1 = %func1% & echo func2 = %func2% & echo func3 = %func3%
	endlocal
	echo globalVar = %globalVar% & echo main = %main% & echo func1 = %func1% & echo func2 = %func2% & echo func3 = %func3%
	endlocal
	
	
	pause
	
	echo ^<------------ func3
	echo:
goto:eof