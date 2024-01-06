@echo off
%dkbatch%

if defined __ goto :variables
set __=.
darkbox -im | call %0 %* | darkbox
set __=
pause >nul
goto :eof

:variables
	mode 32,5
	:: Hide cursor
	echo -h 0
	:: Enable special characters
	@chcp 65001 >nul
	
	set skip-draw=0
	set launched=0

	:: Draw everything first time
	for %%i in (
		"calc"
		"notepad"
		"mspaint"
	) do call :draw 1 %%~i

	goto :main

:main
	:: Input
	set /p i=
	for /f "tokens=1,2,3,4" %%a in ("%i%") do (
		set type=%%a
		set x=%%b
		set y=%%c
		set click=%%d
	)

	:: Debug informations
	rem title Debug: x: %x%, y: %y%

	:: Drawing boxes (skip-draw is used to fix flashing)
	if %skip-draw% equ 0 (
		call :draw 1 calc
		call :draw 1 notepad
		call :draw 1 mspaint
		set skip-draw=1
	) else (
		set skip-draw=0
	)

	:: Detecting collisions
	call :detect-collision 1 12 1 3 "calc.exe"
	call :detect-collision 14 22 1 3 "notepad.exe"
	call :detect-collision 24 30 1 3 "mspaint.exe"
	
	goto :main

:detect-collision
	:: x1, x2, y1, y2, program_name
	if %x% geq %1 if %x% leq %2 if %y% geq %3 if %y% leq %4 (
		if %click% equ 0 (
			call :draw 9 %~n5
			set launched=0
		) else (
			call :draw f %~n5
			if %launched% equ 0 call :launch "%~5"
		)
		set skip-draw=1
	)

	goto :eof

:draw
	if "%2" equ "calc" (
		for /l %%i in (1,1,3) do echo -g 1 %%i -c 0x1%1 -d "████████████"
		echo -g 2 2 -c 0x%10 -d "Calculator"
	) else if "%2" equ "notepad" (
		for /l %%i in (1,1,3) do echo -g 14 %%i -c 0x1%1 -d "█████████"
		echo -g 15 2 -c 0x%10 -d "Notepad"
	) else if "%2" equ "mspaint" (
		for /l %%i in (1,1,3) do echo -g 24 %%i -c 0x1%1 -d "███████"
		echo -g 25 2 -c 0x%10 -d "Paint"
	)

	goto :eof

:launch
	start "" "%~1"
	set launched=1

	goto :eof