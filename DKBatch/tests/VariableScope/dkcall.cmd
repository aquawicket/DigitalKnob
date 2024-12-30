@echo off

:: defaults
set STACK
if not defined dkcall  set "dkcall=call dkcall"
if not defined lvl (set /a lvl=0)
	
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
	
	echo %indent% lvl = %lvl%
::	echo %indent% _1 = %_1%
::	echo %indent% f1 = %f1%
::	echo %indent% n1 = %n1%
::	echo %indent% x1 = %x1%
::	echo %indent% p1 = %p1%
::	echo %indent% ALL = %ALL%
	echo %indent% local = %LOCAL_VAR%
	echo %indent% globalVar = %globalVarA%
	echo %indent% globalVarB = %globalVarB%
	
	
	call setGlobal STACK_%lvl% "%comand% %args%"
	
	:::::::::::::::::::::::::::::
	call %comand% %args%
	:::::::::::::::::::::::::::::
	
	
	
	
	(set /a lvl-=1)
	call setGlobal STACK_%lvl% ""
	call GLOBAL.cmd
	
	
	
	echo:
	echo ^<%indent% %comand%(%args%)
	
	echo %indent% lvl = %lvl%
::	echo %indent% _1 = %_1%
::	echo %indent% f1 = %f1%
::	echo %indent% n1 = %n1%
::	echo %indent% x1 = %x1%
::	echo %indent% p1 = %p1%
::	echo %indent% ALL = %ALL%
	echo %indent% local = %LOCAL_VAR%
	echo %indent% globalVarA = %globalVarA%
	echo %indent% globalVarB = %globalVarB%
	
	
	
exit /b 0