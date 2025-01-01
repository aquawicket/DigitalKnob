@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::if not defined dk_call call :init
::####################################################################
::# dk_call(command args)
::#
::#
:dk_call
	(set /a lvl+=1)
	(set comand=%~1)
	(set comand=%comand:::=\%)
	(set FILE=%~dpnx1)
	(set FUNC=%~n1)
	(set ARGV=%*)
	(set ARGV=!ARGV:%~1=!)
	(set /a ARGC=0)
	for %%a in (!ARGV!) do (set /a ARGC+=1)

::	call :setGlobal "STACK_%lvl%" "%FUNC%"
	

	
	::if "%FUNC%"=="dk_debugFunc" echo [31m ERROR: dk_call cannot be used with dk_debugFunc [0m & %return%
	::if "%FUNC:dk_=%"=="%FUNC%"  echo [31m ERROR: dk_call[%FUNC%]: dk_call can only be used with dk_ FUNCtions [0m & %return%
	
	if exist "%DKBATCH_FUNCTIONS_DIR_%%comand%.cmd" (set "comand=%DKBATCH_FUNCTIONS_DIR_%%comand%.cmd")
	
	::if not exist "%DKBATCH_FUNCTIONS_DIR_%%comand%.cmd" (
	if not exist "%comand%" (
		call dk_source "%comand%"
		rem if not exist "%DKBATCH_FUNCTIONS_DIR_%%FUNC%.cmd" echo [31m ERROR: failed to download %comand%.cmd [0m & %return%
		rem if not exist "%DKBATCH_FUNCTIONS_DIR_%dk_isCRLF.cmd" call dk_source dk_isCRLF
		rem if not exist "%DKBATCH_FUNCTIONS_DIR_%dk_fileToCRLF.cmd" call dk_source dk_fileToCRLF
		rem if exist "%DKBATCH_FUNCTIONS_DIR_%dk_isCRLF.cmd" call dk_isCRLF "%DKBATCH_FUNCTIONS_DIR_%%comand%.cmd" || if exist "%DKBATCH_FUNCTIONS_DIR_%dk_fileToCRLF.cmd" call dk_fileToCRLF "%DKBATCH_FUNCTIONS_DIR_%%comand%.cmd"
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
	::echo dk_call ^> %comand% %ARGV%
    call %comand% %ARGV%
::###### Exit #############################################################################################

::	call :setGlobal STACK_%lvl% ""
	
	:: get all variables from %GLOBAL_FILE% and apply them with GLOBAL_ prefixes removed
::	if exist "%GLOBAL_FILE%" for /F "usebackq delims=" %%a in ("%GLOBAL_FILE%") do (
::		set "line=%%a"
::		set "!line:GLOBAL_=!"
::	)
	
	(set /a lvl-=1)
	
	
	
	::FIXME: I think %endfunction% covers this
    ::exit /b %errorlevel%
%endfunction%

::init
::	set "GLOBAL_FILE=C:\GLOBAL.txt"
::	echo. 2>"%GLOBAL_FILE%"
::	set "dk_call=call dk_call"
::	(set /a lvl=0)
::	call setGlobal "STACK_0" "main"
::exit /b 0




:printConstantVariables
	                      :: (echo:)
                          :: (echo %padB% ###### Constant Variables ######)
	if defined dk_call      (echo %padB% dk_call      = %dk_call%)
	if defined GLOBAL_FILE (echo %padB% GLOBAL_FILE = %GLOBAL_FILE%)
	if defined indent        (echo %padB% indent        = %indent%)
	if defined pad      (echo %padB% pad      = %pad%)
%endfunction%

:printStackVariables
	                    ::  (echo:)
	                    ::  (echo %padB% ###### Stack Variables ######)
						  (echo %padB% LVL  = %LVL%)
	if defined CMND_%LVL% (echo %padB% CMND_%LVL% = !CMND_%LVL%!)
	if defined FILE_%LVL% (echo %padB% FILE_%LVL% = !FILE_%LVL%!)
	if defined FUNC_%LVL% (echo %padB% FUNC_%LVL% = !FUNC_%LVL%!)
	if defined ARGV_%LVL% (echo %padB% ARGV_%LVL% = !ARGV_%LVL%!)
	if defined ARGC_%LVL% (echo %padB% ARGC_%LVL% = !ARGC_%LVL%!)
%endfunction%

:printDirectVariables
	               :: (echo:)
	               :: (echo %padB% ###### Direct Variables ######)
	if defined LVL  (echo %padB% LVL   = %LVL%)
	if defined CMND (echo %padB% CMND  = %CMND%)
	if defined FILE (echo %padB% FILE  = %FILE%)
	if defined FUNC (echo %padB% FUNC  = %FUNC%)
	if defined ARGV (echo %padB% ARGV  = %ARGV%)
	if defined ARGC (echo %padB% ARGC  = %ARGC%)
%endfunction%

:printParentStackVariables
	                      :: (echo:)
	                      :: (echo %padB% ###### Parent Stack Variables ######)							
	if defined PLVL        (echo %padB% PLVL  = %PLVL%)
	if defined CMND_%PLVL% (echo %padB% CMND_%PLVL% = !CMND_%PLVL%!)
	if defined FILE_%PLVL% (echo %padB% FILE_%PLVL% = !FILE_%PLVL%!)
	if defined FUNC_%PLVL% (echo %padB% FUNC_%PLVL% = !FUNC_%PLVL%!)
	if defined ARGV_%PLVL% (echo %padB% ARGV_%PLVL% = !ARGV_%PLVL%!)
	if defined ARGC_%PLVL% (echo %padB% ARGC_%PLVL% = !ARGC_%PLVL%!)
%endfunction%

:printParentDirectVariables
	                :: (echo:)
	                :: (echo %padB% ###### Parent Direct Variables ######)							
	if defined PCMND (echo %padB% PCMND = %PCMND%)
	if defined PFILE (echo %padB% PFILE = %PFILE%)
	if defined PFUNC (echo %padB% PFUNC = %PFUNC%)
	if defined PARGV (echo %padB% PARGV = %PARGV%)
	if defined PARGC (echo %padB% PARGC = %PARGC%)
%endfunction%

:setGlobal name value
	::echo set "%~1=%~2" >> GLOBAL.cmd
	::echo %~1 >> GLOBAL.cmd
	set "%~1=%~2"
	
	:: prefix the variable name with GLOBAL_ and assign a value
	set "GLOBAL_%~1=%~2"
	
	:: place all vairable with a GLOBAL_ prefix into %GLOBAL_FILE%
	set GLOBAL_ > "%GLOBAL_FILE%"

	::endlocal & set "%~1=%~2"
%endfunction%

:dk_printCallStack
	echo:
	echo ############ CALLSTACK ############
	for /l %%x in (1, 1, 100) do (
		(set /a num=100-%%x)
		if defined STACK_!num! (
			call echo !num!: %%STACK_!num!%%
		)
	)
	echo:
%endfunction%







::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
    ::if exist "%DKBATCH_FUNCTIONS_DIR_%dk_debugFunc.cmd" %dk_call% dk_debugFunc 0
 setlocal
    %dk_call% dk_color
    call dk_call dk_color
    %dk_call% dk_color
    call dk_call dk_color
    %dk_call% dk_color
	%dk_call% dk_set myVarB "dk_info('test dk_info message')"
%endfunction%
