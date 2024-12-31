@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

if not defined dk_call  goto:init
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
	(set /a clvl=lvl-1)
	(set CALLER=!STACK_%clvl%!)
	
	(set mark=-----)
	(set indent=)
	for /l %%x in (1, 1, %lvl%) do set "indent=!indent!%mark%"
	call dk_setGlobal "STACK_%lvl%" "%FUNC%"
	

	
	::if "%FUNC%"=="dk_debugFunc" echo [31m ERROR: dk_call cannot be used with dk_debugFunc [0m & %return%
	::if "%FUNC:dk_=%"=="%FUNC%"  echo [31m ERROR: dk_call[%FUNC%]: dk_call can only be used with dk_ FUNCtions [0m & %return%
	
	if exist "%DKBATCH_FUNCTIONS_DIR_%%comand%.cmd" (set "comand=%DKBATCH_FUNCTIONS_DIR_%%comand%.cmd")
	
	::if not exist "%DKBATCH_FUNCTIONS_DIR_%%comand%.cmd" (
	if not exist "%comand%" (
		call dk_source "%comand%"
		rem if not exist "%DKBATCH_FUNCTIONS_DIR_%%FUNC%.cmd" echo [31m ERROR: failed to download %comand%.cmd [0m & %return%
		if not exist "%DKBATCH_FUNCTIONS_DIR_%dk_isCRLF.cmd" call dk_source dk_isCRLF
		if not exist "%DKBATCH_FUNCTIONS_DIR_%dk_fileToCRLF.cmd" call dk_source dk_fileToCRLF
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

	call dk_setGlobal STACK_%lvl% ""
	
	:: get all variables from GLOBAL.txt and apply them with GLOBAL_ prefixes removed
	if exist "GLOBAL.txt" for /F "usebackq delims=" %%a in ("GLOBAL.txt") do (
		set "line=%%a"
		set "!line:GLOBAL_=!"
    )
	
	(set /a lvl-=1)
	
	
	
	::FIXME: I think %endfunction% covers this
    ::exit /b %errorlevel%
%endfunction%

:init
	echo. 2>GLOBAL.txt
	set "dk_call=call dk_call"
	(set /a lvl=0)
	call setGlobal "STACK_0" "main"
exit /b 0



::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
    ::if exist "%DKBATCH_FUNCTIONS_DIR_%dk_debugFunc.cmd" call dk_debugFunc 0
 setlocal
    %dk_call% dk_color
    call dk_call dk_color
    %dk_call% dk_color
    call dk_call dk_color
    %dk_call% dk_color
	%dk_call% dk_set myVarB "dk_info('test dk_info message')"
%endfunction%
