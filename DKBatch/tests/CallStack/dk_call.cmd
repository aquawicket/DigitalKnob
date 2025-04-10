@echo off
::if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)

::####################################################################
::# dk_call(command args)
::#
:dk_call
	if "%~1" equ "" (echo ERROR: use 'call dk_call %%0' at the top of your script to initialize dk_call. & pause & exit 13 )
	
	if not defined endfunction  (set "endfunction=exit /b %errorlevel%")
	
	:: don't add dk_call :functions to the call stack.  i.e :setGlobal, :printCallstack
	::(set "temp=%*")
	::if "!temp:~0,1!" equ ":" (call %temp% && %endfunction%)
	if "%~1" equ "setGlobal" 		(call :%* && %endfunction%)
	if "%~1" equ "printCallStack" 	(call :%* && %endfunction%)
	
	::### Constant Variables ###
	if not defined dk_call 		(set "dk_call=call dk_call")
	if not defined GLOBAL_FILE 	(set "GLOBAL_FILE=C:\GLOBAL.txt")
	if not defined LVL			(set /a "LVL=-1")
	
	(set "pad=")
	(set "padB=      ")
	(set "indent=        ")

	::###### Stack Variables ######
	(set "CMND=%~1") && (set "CMND=!CMND:::=\!")
	(set "FILE=%~dpnx1")
	(set "FUNC=%~n1")
	(set "ARGV=%*")
	(set ARGV=!ARGV:%~1=!)
	(set "ARGC=0") && for %%a in (%ARGV%) do (set /a "ARGC+=1")
	
	::###### Globalize the <STACK>_LVL variables
	(set /a "PLVL=LVL")
	(set /a "LVL+=1")
	for /l %%x in (1, 1, %LVL%) do (set "pad=!pad!%indent%")
	for /l %%x in (1, 1, %LVL%) do (set "padB=!padB!%indent%")	
	(call :setGlobal "CMND_%LVL%" "%CMND%")
	(call :setGlobal "FILE_%LVL%" "%FILE%")
	(call :setGlobal "FUNC_%LVL%" "%FUNC%")
	(call :setGlobal "ARGV_%LVL%" "%ARGV%")
	(call :setGlobal "ARGC_%LVL%" "%ARGC%")
	
	::###### Print function entry #####
	for /f "tokens=4 delims= " %%G in ('chcp') do set _codepage_=%%G
	if not "%_codepage_%" equ "65001" (chcp 65001>nul)
	echo %pad%╚═► !FUNC!(!ARGV!)	&:: https://en.wikipedia.org/wiki/Code_page_437
	call :printStackVariables
	::##################################
	
	if %LVL% lss 1 (%endfunction%)
	
::###### Entry ############################################################################################
	call !FUNC! !ARGV!
::###### Exit #############################################################################################
	
	::###### Print function exit ######
	echo %pad%╔══ !FUNC!(!ARGV!)	&:: https://en.wikipedia.org/wiki/Code_page_437
	echo %pad%▼
	::#################################
	
	(call :setGlobal "CMND_%LVL%" "")
	(call :setGlobal "FILE_%LVL%" "")
	(call :setGlobal "FUNC_%LVL%" "")
	(call :setGlobal "ARGV_%LVL%" "")
	(call :setGlobal "ARGC_%LVL%" "")
	(set /a "PLVL=LVL")
	(set /a "LVL-=1")
	
	:: get all variables from %GLOBAL_FILE% and apply them with GLOBAL_ prefixes removed
	if exist "%GLOBAL_FILE%" for /F "usebackq delims=" %%a in ("%GLOBAL_FILE%") do (
		set "line=%%a"
		set "!line:GLOBAL_=!"
    )
%endfunction%


:printConstantVariables
	if defined dk_call		(echo %padB% dk_call		= %dk_call%)
	if defined GLOBAL_FILE	(echo %padB% GLOBAL_FILE	= %GLOBAL_FILE%)
	if defined indent		(echo %padB% indent			= %indent%)
	if defined pad			(echo %padB% pad			= %pad%)
%endfunction%

:printStackVariables
	if defined LVL			(echo %padB% LVL  = %LVL%)
	if defined CMND_%LVL%	(echo %padB% CMND_%LVL% = !CMND_%LVL%!)
	if defined FILE_%LVL%	(echo %padB% FILE_%LVL% = !FILE_%LVL%!)
	if defined FUNC_%LVL%	(echo %padB% FUNC_%LVL% = !FUNC_%LVL%!)
	if defined ARGV_%LVL%	(echo %padB% ARGV_%LVL% = !ARGV_%LVL%!)
	if defined ARGC_%LVL%	(echo %padB% ARGC_%LVL% = !ARGC_%LVL%!)
%endfunction%

:printParentStackVariables						
	if defined PLVL        (echo %padB% PLVL  = %PLVL%)
	if defined CMND_%PLVL% (echo %padB% CMND_%PLVL% = !CMND_%PLVL%!)
	if defined FILE_%PLVL% (echo %padB% FILE_%PLVL% = !FILE_%PLVL%!)
	if defined FUNC_%PLVL% (echo %padB% FUNC_%PLVL% = !FUNC_%PLVL%!)
	if defined ARGV_%PLVL% (echo %padB% ARGV_%PLVL% = !ARGV_%PLVL%!)
	if defined ARGC_%PLVL% (echo %padB% ARGC_%PLVL% = !ARGC_%PLVL%!)
%endfunction%

:setGlobal name value
	set "%~1=%~2"
	set "GLOBAL_%~1=%~2"			&:: prefix the variable name with GLOBAL_ and assign a value
	set GLOBAL_ > "%GLOBAL_FILE%"	&:: place all vairable with a GLOBAL_ prefix into %GLOBAL_FILE%
%endfunction%

:printCallStack
	echo:
	echo ############ CALLSTACK ############
	for /l %%x in (1, 1, 100) do (
		(set /a num=100-%%x)
		if defined CMND_!num! (call echo !num!: %%CMND_!num!%%)
	)
	echo ###################################
	echo:
%endfunction%