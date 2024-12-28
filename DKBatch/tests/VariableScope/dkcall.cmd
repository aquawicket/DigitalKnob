@echo off

:dkcall

	set "comand=%~1"
	set "args=%*"
	set "args=!args:%~1=!"
	
	
	
	
	
	(set _1=%~1)
	(set f1=%~f1)
	(set n1=%~n1)
	(set x1=%~x1)
	(set np=%~p1)
	
	(set /a lvl+=1)
	(set mark=-----)
	(set indent=)
	for /l %%x in (1, 1, %lvl%) do set "indent=!indent!%mark%"
	
	
	echo:
	echo %indent%^> %comand%(%args%)
	:::::::::::::::::::::::::::::
	call %comand% %args%
	:::::::::::::::::::::::::::::
	echo ^<%indent% %comand%(%args%)
	echo:
	
	(set /a lvl-=1)
	call GLOBAL.cmd
	
	
	
	
exit /b 0