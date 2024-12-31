@echo off
if "%~1" == ":init" goto:init

:dkcall
	(set /a lvl+=1)
	(set FILE=%~dpnx1)
	(set FUNC=%~n1)
	(set ARGV=%*)
	(call set ARGV=%%ARGV:%~1=!%%)
	set ARGC=0
	for %%a in (%ARGV%) do (set /a ARGC+=1)
	(set /a clvl=lvl-1)
	(set CALLER=!STACK_%clvl%!)
	
	(set mark=-----)
	(set indent=)
	for /l %%x in (1, 1, %lvl%) do set "indent=!indent!%mark%"
	call setGlobal "STACK_%lvl%" "%FUNC%"
	
	echo:
	echo %indent%^> %FUNC%(%ARGV%)
	if defined LVL (echo LVL: %LVL%) 
	if defined FILE (echo FILE: %FILE%)
	if defined FUNC (echo FUNC: %FUNC%)
	if defined ARGV (echo ARGV: %ARGV%)
	if defined ARGC (echo ARGC: %ARGC%)
	if defined CALLER (echo CALLER: %CALLER%)

	call PrintCallStack
	
	:::::::::::::::::::::::::::::
	call %FUNC% %ARGV%
	:::::::::::::::::::::::::::::
	
	call setGlobal STACK_%lvl% ""
	call GLOBAL.cmd
	(set /a lvl-=1)
	
	echo:
	echo ^<%indent% %FUNC%(%ARGV%)
	if defined LVL (echo LVL: %LVL%) 
	if defined FILE (echo FILE: %FILE%)
	if defined FUNC (echo FUNC: %FUNC%)
	if defined ARGV (echo ARGV: %ARGV%)
	if defined ARGC (echo ARGC: %ARGC%)
	if defined CALLER (echo CALLER: %CALLER%)

	call PrintCallStack
exit /b 0



:init
	echo ^@echo off > GLOBAL.cmd
	if not defined dkcall  set "dkcall=call dkcall"
	(set /a lvl=0)
	call setGlobal "STACK_0" "main"
exit /b 0