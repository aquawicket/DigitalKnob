@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::###### SETTINGS ######
::(set printCalls=1) 
::(set printEntry=1)
::(set printExit=1)
(set _IGNORE_=dk_debugFunc;dk_echo;)


::####################################################################
::# dk_call(command args)
::#
:dk_call
	if "%~1"=="" (echo ERROR: use 'call dk_call %%0' at the top of your script to initialize dk_call. & pause & exit 13 )
	
	:: don't add these functions to the callstack, just run them
	if "%~1"=="init"				(call :%* && %endfunction%)
	if "%~1"=="pushStack"			(call :%* && %endfunction%)
	if "%~1"=="popStack"			(call :%* && %endfunction%)
	if "%~1"=="setGlobal" 			(call :%* && %endfunction%)
	if "%~1"=="printStackVariables"	(call :%* && %endfunction%)
	
	::###### Stack Variables ######
	(set __CMND__=%~1)
	(set __CMND__=!__CMND__:::=\!)
	(set __FILE__=%~dpnx1)
	(set __FUNC__=%~n1)
	set __ARGV__=%*
	if defined __ARGV__ (set __ARGV__=!__ARGV__:*%1=!)

	call :pushStack %*

	::###### Print function entry ####
	if defined printEntry (call :printEntry)

	if %LVL% lss 1 (exit /b !errorlevel!)

::##### Prepair ###########################################################################################
	if exist "%__CMND__%.cmd" (set __CMND__=%__CMND__%.cmd)
	if exist "%DKBATCH_FUNCTIONS_DIR_%%__CMND__%.cmd" (set __CMND__=%DKBATCH_FUNCTIONS_DIR_%%__CMND__%.cmd)
	
	if not exist "%__CMND__%" (
		call dk_source "%__CMND__%"
		rem if not exist "%DKBATCH_FUNCTIONS_DIR_%%__FUNC__%.cmd" echo [31m ERROR: failed to download %__CMND__%.cmd [0m & %return%
		rem if not exist "%DKBATCH_FUNCTIONS_DIR_%dk_isCRLF.cmd" call dk_source dk_isCRLF
		rem if not exist "%DKBATCH_FUNCTIONS_DIR_%dk_fileToCRLF.cmd" call dk_source dk_fileToCRLF
		rem if exist "%DKBATCH_FUNCTIONS_DIR_%dk_isCRLF.cmd" call dk_isCRLF "%DKBATCH_FUNCTIONS_DIR_%%__CMND__%.cmd" || if exist "%DKBATCH_FUNCTIONS_DIR_%dk_fileToCRLF.cmd" call dk_fileToCRLF "%DKBATCH_FUNCTIONS_DIR_%%__CMND__%.cmd"
    )

::###### Entry ############################################################################################
	if defined printCalls (echo dk_call ^> %__CMND__% !__ARGV__!)

	call %__CMND__% %__ARGV__% || goto error_handler
	
	if %errorlevel% NEQ 0 (set RTN_CODE=%errorlevel%) else (set RTN_CODE=0)
	set RTN_BOOL=0
	goto end_handler
	
	:error_handler
	if %errorlevel% NEQ 0 (set RTN_CODE=%errorlevel%) else (set RTN_CODE=0)
	set RTN_BOOL=1
	
	:end_handler
::###### Exit #############################################################################################
	
	::###### Print function exit ######
	if defined printExit (call :printExit)
	
	call :popStack
exit /b %RTN_CODE%




::####################################################################
::# :init
::#
:init
	set "dk_call=call dk_call"
	set globalize=for /F "delims=" %%a in ('set global.') do endlocal^& call set _line_=%%a^& call set %%_line_:global.=%%
	
::	(set endfunction=exit /b !errorlevel!)
::	(set return=exit /b !errorlevel!)

::	(set endfunction=echo !errorlevel!^& exit /b !errorlevel!)
::	(set return=echo !errorlevel!^& exit /b !errorlevel!)
	
::	(set endfunction=echo !errorlevel!^& call dk_getError)
::	(set return=echo !errorlevel!^& call dk_getError)
	
	(set endfunction=call dk_getError^& exit /b !errorlevel!)
	(set return=call dk_getError^& exit /b !errorlevel!)
	
	::(set endfunction=if not "!errorlevel!"=="0" call dk_getError^& exit /b 0)
	::set endfunction=call dk_getError^& !globalize!^& exit /b 0
	::set return=call dk_getError^& !globalize!^& exit /b 0
	set /a "LVL=0"
	set "ESC="
	set "clr=%ESC%[0m"
	set "pad=%clr%"
	set "padB=      "
	set "indent=        "
%endfunction%

::####################################################################
::# :printEntry
::#
:printEntry
	if defined _IGNORE_ if not "X!_IGNORE_:%__FUNC__%=!X"=="X%_IGNORE_%X" (%endfunction%)
	
	call :updateIndent
	for /f "tokens=4 delims= " %%G in ('chcp') do set _codepage_=%%G
	if not "%_codepage_%"=="65001" chcp 65001>nul
	echo %pad%╚═► !__FUNC__!(!__ARGV__!)
%endfunction%

::####################################################################
::# :printExit
::#
:printExit
	if defined _IGNORE_ if not "X!_IGNORE_:%__FUNC__%=!X"=="X%_IGNORE_%X" (%endfunction%)
	
	call :updateIndent
	echo %pad%╔══ !__FUNC__!(!__ARGV__!)
	echo %pad%▼
%endfunction%

::####################################################################
::# :printConstantVariables
::#
:printConstantVariables
	call :updateIndent
	if defined dk_call		(echo %padB% dk_call		= %dk_call%)
	if defined indent		(echo %padB% indent			= %indent%)
	if defined pad			(echo %padB% pad			= %pad%)
%endfunction%

::####################################################################
::# :printStackVariables
::#
:printStackVariables
	call :updateIndent
	if defined LVL				(echo %padB% LVL  = %LVL%)
	if defined __STACK__%LVL%	(echo %padB% __STACK__%LVL% = !__STACK__%LVL%!)
%endfunction%

::####################################################################
::# :printParentStackVariables
::#
:printParentStackVariables
	(set /a PLVL=LVL-1)
	call :updateIndent	
	if defined PLVL        		(echo %padB% PLVL  = %PLVL%)
	if defined __STACK__%PLVL% 	(echo %padB% __STACK__%PLVL% = !__STACK__%PLVL%!)
%endfunction%

::####################################################################
::# :setGlobal
::#
:setGlobal name value
	set argv=%*
	if defined argv (set argv=!argv:*%1=!)
	(set %~1=%argv%)
	(set global.%~1=%argv%)		&:: prefix the variable name with global. and assign a value
%endfunction%

::####################################################################
::# :updateIndent
::#
:updateIndent
	(set pad=)
	(set padB=)
	for /l %%x in (1, 1, %LVL%) do (set pad=!pad!%indent%)
	for /l %%x in (1, 1, %LVL%) do (set padB=!padB!%indent%)
%endfunction%

::####################################################################
::# :pushStack
::#
:pushStack file args
	(set /a LVL+=1)
	(call :setGlobal __STACK__%LVL% %time% %*)
%endfunction%

::####################################################################
::# :popStack
::#
:popStack
	(call :setGlobal __STACK__%LVL%)
	(set /a LVL-=1)
%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0

	%dk_call% dk_test
%endfunction%

