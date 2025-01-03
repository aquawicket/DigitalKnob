@echo off
::if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::####################################################################
::# dk_call(command args)
::#
:dk_call
	if "%~1"=="" (echo ERROR: use 'call dk_call %%0' at the top of your script to initialize dk_call. & pause & exit 13 )
	
	::### Constant Variables ###
	if not defined dk_call 		(set "dk_call=call dk_call")
	if not defined GLOBAL_FILE 	(set "GLOBAL_FILE=C:\GLOBAL.txt")
	(set "pad=")
	(set "padB=      ")
	(set "indent=        ")
	
	::###### Stack Variables ######
	if not defined LVL 	(set /a "LVL=-1")
	(set /a "LVL+=1")
	for /l %%x in (1, 1, %LVL%) do (set "pad=!pad!%indent%")
	for /l %%x in (1, 1, %LVL%) do (set "padB=!padB!%indent%")	
	(set "CMND=%~1")
	(call :setGlobal "CMND_%LVL%" "%CMND:::=\%")
	(call :setGlobal "FILE_%LVL%" "%~dpnx1")
	(call :setGlobal "FUNC_%LVL%" "%~n1")
	(set "ARGV=%*")
	(call :setGlobal "ARGV_%LVL%" "%ARGV%")
	(set ARGC=0) && for %%a in (%ARGV%) do (set /a ARGC+=1)
	(call :setGlobal "ARGC_%LVL%" "%ARGC%")
	
	::###### Parent Stack Variables ######	
	(set /a "PLVL=LVL-1")
	
	:: https://en.wikipedia.org/wiki/Code_page_437║
	echo %pad%╚═► !FUNC_%LVL%!(!ARGV_%LVL%!)
	call :printStackVariables
	
	if %LVL% lss 1 (exit /b %errorlevel%)
	::if "!FUNC_%LVL%!"=="setGlobal" (set FUNC_%LVL%=:setGlobal)
::###### Entry ############################################################################################
	call !FUNC_%LVL%! !ARGV_%LVL%!
::###### Exit #############################################################################################
	
	echo %pad%╔══ !FUNC_%LVL%!(!ARGV_%LVL%!)	&:: https://en.wikipedia.org/wiki/Code_page_437
	echo %pad%▼
	
	(call :setGlobal "CMND_%LVL%" "")
	(call :setGlobal "FILE_%LVL%" "")
	(call :setGlobal "FUNC_%LVL%" "")
	(call :setGlobal "ARGV_%LVL%" "")
	(call :setGlobal "ARGC_%LVL%" "")
	(set /a LVL-=1)
	(set /a PLVL=LVL+1)
	
	:: get all variables from %GLOBAL_FILE% and apply them with GLOBAL_ prefixes removed
	if exist "%GLOBAL_FILE%" for /F "usebackq delims=" %%a in ("%GLOBAL_FILE%") do (
		set "line=%%a"
		set "!line:GLOBAL_=!"
    )
	
	::call :printStackVariables
	
	
exit /b %errorlevel%


:printConstantVariables
	if defined dk_call		(echo %padB% dk_call		= %dk_call%)
	if defined GLOBAL_FILE	(echo %padB% GLOBAL_FILE	= %GLOBAL_FILE%)
	if defined indent		(echo %padB% indent			= %indent%)
	if defined pad			(echo %padB% pad			= %pad%)
exit /b %errorlevel%

:printStackVariables
	if defined LVL			(echo %padB% LVL  = %LVL%)
	if defined CMND_%LVL%	(echo %padB% CMND_%LVL% = !CMND_%LVL%!)
	if defined FILE_%LVL%	(echo %padB% FILE_%LVL% = !FILE_%LVL%!)
	if defined FUNC_%LVL%	(echo %padB% FUNC_%LVL% = !FUNC_%LVL%!)
	if defined ARGV_%LVL%	(echo %padB% ARGV_%LVL% = !ARGV_%LVL%!)
	if defined ARGC_%LVL%	(echo %padB% ARGC_%LVL% = !ARGC_%LVL%!)
exit /b %errorlevel%

:printParentStackVariables						
	if defined PLVL        (echo %padB% PLVL  = %PLVL%)
	if defined CMND_%PLVL% (echo %padB% CMND_%PLVL% = !CMND_%PLVL%!)
	if defined FILE_%PLVL% (echo %padB% FILE_%PLVL% = !FILE_%PLVL%!)
	if defined FUNC_%PLVL% (echo %padB% FUNC_%PLVL% = !FUNC_%PLVL%!)
	if defined ARGV_%PLVL% (echo %padB% ARGV_%PLVL% = !ARGV_%PLVL%!)
	if defined ARGC_%PLVL% (echo %padB% ARGC_%PLVL% = !ARGC_%PLVL%!)
exit /b %errorlevel%

:setGlobal name value
	set "%~1=%~2"
	set "GLOBAL_%~1=%~2"			&:: prefix the variable name with GLOBAL_ and assign a value
	set GLOBAL_ > "%GLOBAL_FILE%"	&:: place all vairable with a GLOBAL_ prefix into %GLOBAL_FILE%
exit /b 0

:PrintCallStack
	echo:
	echo ############ CALLSTACK ############
	for /l %%x in (1, 1, 100) do (
		(set /a num=100-%%x)
		if defined CMND_!num! (
			call echo !num!: %%CMND_!num!%%
		)
	)
	echo:
	pause
exit /b 0