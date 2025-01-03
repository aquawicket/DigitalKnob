@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

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
	::(call :setGlobal "CMND_%LVL%" "%CMND:::=\%")
	
::###############################################################################################################################################
	(set CMND=%CMND:::=\%)
	(set FILE=%~dpnx1)
	(set FUNC=%~n1)
	(set ARGV=%*)
	(set ARGV=!ARGV:%~1=!)
	(set /a ARGC=0)
	for %%a in (!ARGV!) do (set /a ARGC+=1)

	::call :setGlobal "STACK_%lvl%" "%FUNC%"
	
	::if "%FUNC%"=="dk_debugFunc" echo [31m ERROR: dk_call cannot be used with dk_debugFunc [0m & %return%
	::if "%FUNC:dk_=%"=="%FUNC%"  echo [31m ERROR: dk_call[%FUNC%]: dk_call can only be used with dk_ FUNCtions [0m & %return%
	
	if exist "%DKBATCH_FUNCTIONS_DIR_%%CMND%.cmd" (set "CMND=%DKBATCH_FUNCTIONS_DIR_%%CMND%.cmd")
	
	::if not exist "%DKBATCH_FUNCTIONS_DIR_%%CMND%.cmd" (
	if not exist "%CMND%" (
		call dk_source "%CMND%"
		rem if not exist "%DKBATCH_FUNCTIONS_DIR_%%FUNC%.cmd" echo [31m ERROR: failed to download %CMND%.cmd [0m & %return%
		rem if not exist "%DKBATCH_FUNCTIONS_DIR_%dk_isCRLF.cmd" call dk_source dk_isCRLF
		rem if not exist "%DKBATCH_FUNCTIONS_DIR_%dk_fileToCRLF.cmd" call dk_source dk_fileToCRLF
		rem if exist "%DKBATCH_FUNCTIONS_DIR_%dk_isCRLF.cmd" call dk_isCRLF "%DKBATCH_FUNCTIONS_DIR_%%CMND%.cmd" || if exist "%DKBATCH_FUNCTIONS_DIR_%dk_fileToCRLF.cmd" call dk_fileToCRLF "%DKBATCH_FUNCTIONS_DIR_%%CMND%.cmd"
    )
	:dk_exists

::	:dk_call_stack
::	set /a "frame=%DKSTACK_length%-1"
::	call set "THIS=%%DKSTACK[%frame%].__FILE__%% %*"
::	
	if ERRORLEVEL 1 %dk_call% set "EXIT_CODE=%ERRORLEVEL%"
	rem if not defined EXIT_CODE (
		rem set buffer9=%buffer8%
		rem set buffer8=%buffer7%
		rem set buffer7=%buffer6%
		rem set buffer6=%buffer5%
		rem set buffer5=%buffer4%
		rem set buffer4=%buffer3%
		rem set buffer3=%buffer2%
		rem set buffer2=%buffer1%
		rem set buffer1=%buffer0%
		rem set buffer0=%THIS%
		rem title %buffer%
	rem )

	if defined EXIT_CODE (
		rem title %buffer0%
		rem echo:
		rem echo ### LAST 10 CALLS - oldest first ###
		rem echo %buffer9%
		rem echo %buffer8%
		rem echo %buffer7%
		rem echo %buffer6%
		rem echo %buffer5%
		rem echo %buffer4%
		rem echo %buffer3%
		rem echo %buffer2%
		rem echo %buffer1%
		rem echo %buffer0%
		call dk_printCallStack
		exit %EXIT_CODE%
	)
	::if defined EXIT_CODE (echo ERROR ERROR ERROR ERROR ERROR)
	::if not defined EXIT_CODE (title "%DKSTACK[0].__FILE__%")

::###### Entry ############################################################################################
	::echo dk_call ^> %CMND% %ARGV%
    call %CMND% %ARGV%
::###### Exit #############################################################################################

::	call :setGlobal STACK_%lvl% ""
	
	:: get all variables from %GLOBAL_FILE% and apply them with GLOBAL_ prefixes removed
::	if exist "%GLOBAL_FILE%" for /F "usebackq delims=" %%a in ("%GLOBAL_FILE%") do (
::		set "line=%%a"
::		set "!line:GLOBAL_=!"
::	)
	
	(set /a lvl-=1)
%endfunction%




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







::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	::if exist "%DKBATCH_FUNCTIONS_DIR_%dk_debugFunc.cmd" %dk_call% dk_debugFunc 0

	%dk_call% dk_color
	call dk_call dk_color
	%dk_call% dk_color
	call dk_call dk_color
	%dk_call% dk_color
	%dk_call% dk_set myVarB "dk_info('test dk_info message')"
%endfunction%
