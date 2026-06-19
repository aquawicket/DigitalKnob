:: https://www.dostips.com/forum/viewtopic.php?t=9265


@echo off
setlocal enableDelayedExpansion

:main
	::echo TestA = "%TestA:&call:TestA=&echo !TestA!%
	set get=&call:TestA
	echo TestA = '%TestA:!get!=!TestA!%'
	echo|set/p=TestA = '%TestA:&call:TestA=&echo|set/p=!TestA!%'&echo.
	echo|set/p=TestA = '%TestA:&call:TestA=&echo|set/p=!TestA!%'&echo.
	echo|set/p=TestA = '%TestA:&call:TestA=&echo|set/p=!TestA!%'&echo.
	pause
	
	::echo|set /p"=TestB = "%:&call :TestB=&!TestB!%
	echo|set/p=TestB = '%TestB:&call:TestB=&echo|set/p=!TestB!%'&echo.
	echo|set/p=TestB = '%TestB:&call:TestB=&echo|set/p=!TestB!%'&echo.
	echo|set/p=TestB = '%TestB:&call:TestB=&echo|set/p=!TestB!%'&echo.
	pause
	
	::echo|set /p"=TestC = "%:&call:TestC=&echo !TestC!%
	echo|set/p=TestC = '%TestC:&call:TestC=&echo|set/p=!TestC!%'&echo.
	echo|set/p=TestC = '%TestC:&call:TestC=&echo|set/p=!TestC!%'&echo.
	echo|set/p=TestC = '%TestC:&call:TestC=&echo|set/p=!TestC!%'&echo.
	pause
	
	echo|set/p=TestD = '%TestD:&call:TestD=&echo|set/p=!TestD!%'&echo.
	echo|set/p=TestD = '%TestD:&call:TestD=&echo|set/p=!TestD!%'&echo.
	echo|set/p=TestD = '%TestD:&call:TestD=&echo|set/p=!TestD!%'&echo.
	pause

	
	echo|set /p"=TestE = "%:&call:TestE=&echo ### !TestE! ###%
	pause

exit /b 0

:get
	call :%~1
exit /b 0

:TestA
	set "TestA=NewValue"
exit /b 0

:TestB
	for /f "usebackq tokens=*" %%a in (`echo a b c`) do (set "TestB=%%a")
exit /b 0

:TestC
	for /f "usebackq tokens=*" %%a in (`ver`) do (set "TestC=%%a")
exit /b 0

:TestD
	for /f "usebackq tokens=*" %%a in (`dir`) do (set "TestD=%%a")
exit /b 0



:TestE
	for /f "usebackq tokens=*" %%a in (`ver`) do (set "TestE=%%a")
exit /b 0

:::func
::	echo 1 = %~1
::exit /b 0


