@echo off

:: defaults

	
:dkcall
	(set /a lvl+=1)
	set "comand=%~1"
	set "args=%*"
	set "args=!args:%~1=!"
	(set _1=%~1)
	(set f1=%~f1)
	(set n1=%~n1)
	(set x1=%~x1)
	(set np=%~p1)
	(set mark=-----)
	(set indent=)
	for /l %%x in (1, 1, %lvl%) do set "indent=!indent!%mark%"
	call setGlobal "STACK_%lvl%" "%comand% %args%"
	
	echo:
	echo %indent%^> %comand%(%args%)
	if defined STACK_0 (echo 0: !STACK%_0!)
	if defined STACK_1 (echo 1: !STACK%_1!)
	if defined STACK_2 (echo 2: !STACK%_2!)
	if defined STACK_3 (echo 3: !STACK%_3!)
	if defined STACK_4 (echo 4: !STACK%_4!)
	
	:::::::::::::::::::::::::::::
	call %comand% %args%
	:::::::::::::::::::::::::::::
	
	call setGlobal STACK_%lvl% ""
	(set /a lvl-=1)
	call GLOBAL.cmd
	
	echo:
	echo ^<%indent% %comand%(%args%)
	if defined STACK_0 (echo 0: !STACK%_0!)
	if defined STACK_1 (echo 1: !STACK%_1!)
	if defined STACK_2 (echo 2: !STACK%_2!)
	if defined STACK_3 (echo 3: !STACK%_3!)
	if defined STACK_4 (echo 4: !STACK%_4!)

exit /b 0