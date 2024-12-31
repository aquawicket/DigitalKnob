@echo off

:dkcall
	if "%~1"=="" (echo ERROR: use 'call dkcall %%0' at the top of your script to initialize dkcall. & pause & exit 13 )
	
	::### Constant Variables ###
	if not defined dkcall 		(set "dkcall=call dkcall")
	if not defined GLOBAL_FILE 	(set "GLOBAL_FILE=C:\GLOBAL.txt")
	if not defined mark 		(set "mark=   ")
	if not defined markb 		(set "markb=   ")
	if not defined indent 		(set "indent=")
	if not defined indentB 		(set "indentB=   ")
	
	::###### Stack Variables ######
	if not defined LVL 	(set /a "LVL=-1")
	(set /a "LVL+=1")
	for /l %%x in (1, 1, %LVL%) do (set "indent=!indent!%mark%")
	::(set /a "LVLB=LVL+1")
	for /l %%x in (1, 1, %LVL%) do (set "indentB=!indentB!%markB%")	
	(set "CMND=%~1")
	(call setGlobal "CMND_%LVL%" "%CMND:::=\%")
	(call setGlobal "FILE_%LVL%" "%~dpnx1")
	(call setGlobal "FUNC_%LVL%" "%~n1")
	(set "ARGV=%*")
	(call setGlobal "ARGV_%LVL%" "%ARGV%")
	(set ARGC=0) && for %%a in (%ARGV%) do (set /a ARGC+=1)
	(call setGlobal "ARGC_%LVL%" "%ARGC%")
	
	::###### Direct Variables ######
	(set "CMND=!CMND_%LVL%!")
	(set "FILE=!FILE_%LVL%!")
	(set "FUNC=!FUNC_%LVL%!")
	(set "ARGV=!ARGV_%LVL%!")
	(set "ARGC=!ARGC_%LVL%!")
	
	::###### Parent Stack Variables ######	
	(set /a "PLVL=LVL-1")
	
	::###### Parent Direct Variables ######
	(set "PCMND=!CMND_%PLVL%!")
	(set "PFILE=!FILE_%PLVL%!")
	(set "PFUNC=!FUNC_%PLVL%!")
	(set "PARGV=!ARGV_%PLVL%!")
	(set "PARGC=!ARGC_%PLVL%!")
	
	echo:
	echo %indent%--^> %FUNC%(%ARGV%)
	::call :printStackVariables
	call :printDirectVariables
	::call :printParentStackVariables
	call :printParentDirectVariables
	
	if %LVL% lss 1 (exit /b %errorlevel%)
::###### Entry ############################################################################################
	call %CMND% %ARGV%
::###### Exit #############################################################################################
	
	call setGlobal STACK_%LVL% ""
	
	:: get all variables from %GLOBAL_FILE% and apply them with GLOBAL_ prefixes removed
	if exist "%GLOBAL_FILE%" for /F "usebackq delims=" %%a in ("!GLOBAL_FILE!") do (
		rem echo line = %%a
		set "line=%%a"
		set "!line:GLOBAL_=!"
    )
	(set /a LVL-=1)
	
	echo:
	echo %indentB%^<-- %FUNC%(%ARGV%)
	
	::call :printStackVariables
	call :printDirectVariables
	::call :printParentStackVariables
	call :printParentDirectVariables

exit /b %errorlevel%


:printConstantVariables
	                      :: (echo:)
                          :: (echo %indentB% ###### Constant Variables ######)
	if defined dkcall      (echo %indentB% dkcall      = %dkcall%)
	if defined GLOBAL_FILE (echo %indentB% GLOBAL_FILE = %GLOBAL_FILE%)
	if defined mark        (echo %indentB% mark        = %mark%)
	if defined indent      (echo %indentB% indent      = %indent%)
exit /b %errorlevel%

:printStackVariables
	                    ::  (echo:)
	                    ::  (echo %indentB% ###### Stack Variables ######)
	if defined CMND_%LVL% (echo %indentB% CMND_%LVL% = !CMND_%LVL%!)
	if defined FILE_%LVL% (echo %indentB% FILE_%LVL% = !FILE_%LVL%!)
	if defined FUNC_%LVL% (echo %indentB% FUNC_%LVL% = !FUNC_%LVL%!)
	if defined ARGV_%LVL% (echo %indentB% ARGV_%LVL% = !ARGV_%LVL%!)
	if defined ARGC_%LVL% (echo %indentB% ARGC_%LVL% = !ARGC_%LVL%!)
exit /b %errorlevel%

:printDirectVariables
	               :: (echo:)
	               :: (echo %indentB% ###### Direct Variables ######)
	if defined LVL  (echo %indentB% LVL   = %LVL%)
	if defined CMND (echo %indentB% CMND  = %CMND%)
	if defined FILE (echo %indentB% FILE  = %FILE%)
	if defined FUNC (echo %indentB% FUNC  = %FUNC%)
	if defined ARGV (echo %indentB% ARGV  = %ARGV%)
	if defined ARGC (echo %indentB% ARGC  = %ARGC%)
exit /b %errorlevel%

:printParentStackVariables
	                      :: (echo:)
	                      :: (echo %indentB% ###### Parent Stack Variables ######)							
	if defined PLVL        (echo %indentB% PLVL  = %PLVL%)
	if defined CMND_%PLVL% (echo %indentB% CMND_%PLVL% = !CMND_%PLVL%!)
	if defined FILE_%PLVL% (echo %indentB% FILE_%PLVL% = !FILE_%PLVL%!)
	if defined FUNC_%PLVL% (echo %indentB% FUNC_%PLVL% = !FUNC_%PLVL%!)
	if defined ARGV_%PLVL% (echo %indentB% ARGV_%PLVL% = !ARGV_%PLVL%!)
	if defined ARGC_%PLVL% (echo %indentB% ARGC_%PLVL% = !ARGC_%PLVL%!)
exit /b %errorlevel%

:printParentDirectVariables
	                :: (echo:)
	                :: (echo %indentB% ###### Parent Direct Variables ######)							
	if defined PCMND (echo %indentB% PCMND = %PCMND%)
	if defined PFILE (echo %indentB% PFILE = %PFILE%)
	if defined PFUNC (echo %indentB% PFUNC = %PFUNC%)
	if defined PARGV (echo %indentB% PARGV = %PARGV%)
	if defined PARGC (echo %indentB% PARGC = %PARGC%)
exit /b %errorlevel%
