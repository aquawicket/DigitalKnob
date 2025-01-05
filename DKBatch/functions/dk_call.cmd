@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

(set LiveCallStack=1)

::####################################################################
::# dk_call(command args)
::#
:dk_call
	if "%~1"=="" (echo ERROR: use 'call dk_call %%0' at the top of your script to initialize dk_call. & pause & exit 13 )
	
	if not defined endfunction  (set endfunction=exit /b %errorlevel%)
	
	:: don't functions in this file  i.e :setGlobal, :printCallstack
	::(set "temp=%*")
	::if "!temp:~0,1!"==":" (call %temp% && %endfunction%)
	if "%~1"=="setGlobal" 		(call %* && %endfunction%)
	if "%~1"=="printCallStack" 	(call %* && %endfunction%)
	
	::### Constant Variables ###
	if not defined dk_call		(set "dk_call=call dk_call")
	if not defined GLOBAL_FILE 	(set "GLOBAL_FILE=C:\GLOBAL.txt")
	if not defined LVL			(set /a "LVL=-1")
	if not defined ESC			(set ESC=)
	if not defined clr			(set clr=%ESC%[0m)
	
	(set "pad=%clr%")
	(set "padB=      ")
	(set "indent=        ")
	
	::###### Stack Variables ######
	(set __TIME__=%time%)
	(set __CMND__=%~1) && (set __CMND__=!__CMND__:::=\!)
	(set __FILE__=%~dpnx1)
	(set __FUNC__=%~n1)
	for /f "tokens=1,* delims= " %%a in ("%*") do (set __ARGV__=%%b)
	(set __ARGC__=0) && for %%a in (%__ARGV__%) do (set /a __ARGC__+=1)
	
	::###### Globalize the <STACK>_LVL variables
	(set /a PLVL=LVL)
	(set /a LVL+=1)
	for /l %%x in (1, 1, %LVL%) do (set pad=!pad!%indent%)
	for /l %%x in (1, 1, %LVL%) do (set padB=!padB!%indent%)
	(call :setGlobal __CMND__%LVL% %__CMND__%)
	(call :setGlobal __FILE__%LVL% %__FILE__%)
	(call :setGlobal __FUNC__%LVL% %__FUNC__%)
	(call :setGlobal __ARGV__%LVL% %__ARGV__%)
	(call :setGlobal __ARGC__%LVL% %__ARGC__%)

	::###### Print function entry ####
	if defined LiveCallStack (call :printEntry)
	::##################################

	if %LVL% lss 1 (%endfunction%)

::##### Prepair ###########################################################################################
	if exist "%DKBATCH_FUNCTIONS_DIR_%%__CMND__%.cmd" (set __CMND__=%DKBATCH_FUNCTIONS_DIR_%%__CMND__%.cmd)
	
	if not exist "%__CMND__%" (
		call dk_source "%__CMND__%"
		rem if not exist "%DKBATCH_FUNCTIONS_DIR_%%__FUNC__%.cmd" echo [31m ERROR: failed to download %__CMND__%.cmd [0m & %return%
		rem if not exist "%DKBATCH_FUNCTIONS_DIR_%dk_isCRLF.cmd" call dk_source dk_isCRLF
		rem if not exist "%DKBATCH_FUNCTIONS_DIR_%dk_fileToCRLF.cmd" call dk_source dk_fileToCRLF
		rem if exist "%DKBATCH_FUNCTIONS_DIR_%dk_isCRLF.cmd" call dk_isCRLF "%DKBATCH_FUNCTIONS_DIR_%%__CMND__%.cmd" || if exist "%DKBATCH_FUNCTIONS_DIR_%dk_fileToCRLF.cmd" call dk_fileToCRLF "%DKBATCH_FUNCTIONS_DIR_%%__CMND__%.cmd"
    )

	if ERRORLEVEL 1 %dk_call% (set EXIT_CODE=%ERRORLEVEL%)
	if defined EXIT_CODE (
		call :PrintCallStack
		exit %EXIT_CODE%
	)

::###### Entry ############################################################################################
::	echo dk_call ^> %__CMND__% !__ARGV__!
    call %__CMND__% %__ARGV__%
::###### Exit #############################################################################################
	
	::###### Print function exit ######
	if defined LiveCallStack (call :printExit)
	::#################################
	
	::###### Globalize the <STACK>_LVL variables
	(call :setGlobal __CMND__%LVL%)
	(call :setGlobal __FILE__%LVL%)
	(call :setGlobal __FUNC__%LVL%)
	(call :setGlobal __ARGV__%LVL%)
	(call :setGlobal __ARGC__%LVL%)
	(set /a PLVL=LVL)
	(set /a LVL-=1)
	
	:: get all variables from %GLOBAL_FILE% and apply them with GLOBAL_ prefixes removed
	if exist "%GLOBAL_FILE%" for /F "usebackq delims=" %%a in ("%GLOBAL_FILE%") do (
		(set line=%%a)
		(set !line:#GLOBAL$#=!)
    )
	
	::###### Stack Variables ######
	(set __CMND__=!__CMND__%LVL%!)
	(set __FILE__=!__FILE__%LVL%!)
	(set __FUNC__=!__FUNC__%LVL%!)
	(set __ARGV__=!__ARGV__%LVL%!)
	(set __ARGC__=!__ARGC__%LVL%!)
%endfunction%


:printEntry
	for /f "tokens=4 delims= " %%G in ('chcp') do set _codepage_=%%G
	if not "%_codepage_%"=="65001" chcp 65001>nul
	echo %pad%╚═► !__FUNC__!(!__ARGV__!)
::	call :printStackVariables
%endfunction%

:printExit
	echo %pad%╔══ !__FUNC__!(!__ARGV__!)
	echo %pad%▼
%endfunction%

:printConstantVariables
	if defined dk_call		(echo %padB% dk_call		= %dk_call%)
	if defined GLOBAL_FILE	(echo %padB% GLOBAL_FILE	= %GLOBAL_FILE%)
	if defined indent		(echo %padB% indent			= %indent%)
	if defined pad			(echo %padB% pad			= %pad%)
%endfunction%

:printStackVariables
	if defined LVL				(echo %padB% LVL  = %LVL%)
	if defined __CMND__%LVL%	(echo %padB% __CMND__%LVL% = !__CMND__%LVL%!)
	if defined __FILE__%LVL%	(echo %padB% __FILE__%LVL% = !__FILE__%LVL%!)
	if defined __FUNC__%LVL%	(echo %padB% __FUNC__%LVL% = !__FUNC__%LVL%!)
	if defined __ARGV__%LVL%	(echo %padB% __ARGV__%LVL% = !__ARGV__%LVL%!)
	if defined __ARGC__%LVL%	(echo %padB% __ARGC__%LVL% = !__ARGC__%LVL%!)
%endfunction%

:printParentStackVariables						
	if defined PLVL        		(echo %padB% PLVL  = %PLVL%)
	if defined __CMND__%PLVL% 	(echo %padB% __CMND__%PLVL% = !__CMND__%PLVL%!)
	if defined __FILE__%PLVL% 	(echo %padB% __FILE__%PLVL% = !__FILE__%PLVL%!)
	if defined __FUNC__%PLVL% 	(echo %padB% __FUNC__%PLVL% = !__FUNC__%PLVL%!)
	if defined __ARGV__%PLVL% 	(echo %padB% __ARGV__%PLVL% = !__ARGV__%PLVL%!)
	if defined __ARGC__%PLVL% 	(echo %padB% __ARGC__%PLVL% = !__ARGC__%PLVL%!)
%endfunction%

:setGlobal name value
	for /f "tokens=1,* delims= " %%a in ("%*") do (set argv=%%b)
	(set %~1=%argv%)
	(set #GLOBAL#%~1=%argv%)			&:: prefix the variable name with GLOBAL_ and assign a value
	set #GLOBAL# > "%GLOBAL_FILE%"	&:: place all vairable with a GLOBAL_ prefix into %GLOBAL_FILE%
%endfunction%

:printCallStack
	echo:
	echo ############ CALLSTACK ############
	for /l %%x in (1, 1, 100) do (
		(set /a num=100-%%x)
		if defined __CMND__!num! (
			call echo !num!: %%__CMND__!num!%%
		)
	)
	echo:
	pause
%endfunction%







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
