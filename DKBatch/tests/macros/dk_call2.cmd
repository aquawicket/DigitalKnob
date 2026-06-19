@echo off
setlocal

rem call "%~dp0macro.rtnJeb.cmd"
if not defined LF (set LF=^
%=Do not remove this line=%
)
if not defined \n (set \n=^^^
%= DO NOT REMOVE THIS LINE =%
)
rem if not defined \n (set ^"\n=^^^%LF%%LF%^%LF%%LF%^^")
if NOT DEFINED ESC (set "ESC=")


call :dk_loadMacro "%~f0" dk_call2_FUNC
setlocal enableDelayedExpansion
call :main %*
exit /b
	



:dk_loadMacro
	echo :dk_loadMacro %*

	if "!!"=="" (
		echo ERROR: Delayed Expansion must be disabled while defining macros
		pause
		exit /b
	)

	if DEFINED template2 (
		echo %ESC%[31mERROR:1 @ %~nx0 ^>:template2 ALREADY DEFINED%ESC%[0m
		echo.
		exit /b 1
	) else set ^"template2=for %%# in (1 2) do if %%#==2 (%\n%
		setlocal EnableDelayedExpansion%\n%
		echo argv = !argv!%\n%
		if defined argv (%\n%
			set argv=!argv:~1!%\n%
			for /F "delims=" %%* in ("!argv!") do (%\n%
			endlocal%\n%
			endlocal%\n%"
		
	if DEFINED template2B (
			echo %ESC%[31mERROR:1 @ %~nx0 ^>:template2 ALREADY DEFINED%ESC%[0m
			echo.
			exit /b 1
	) else set ^"template2B=)%\n%
		) else (%\n%
			echo %ESC%[31mERROR:1 @ %~nx0 ^^^>dk_call2 EMPTY COMMAND%ESC%[0m%\n%
			echo.%\n%
		)%\n%
	) ELSE setlocal DisableDelayedExpansion ^& set argv="

	setlocal EnableDelayedExpansion
::	echo :dk_loadMacro %*
	echo.
	rem  call :readMacro "%UserProfile%\Digital Knob\Development\DKBatch\tests\macros\MacroFile.cmd" readMacroABC
	rem call :readMacro "%~1" %2 %3 %4 %5 %6 %7 %8 %9
	
	

	

rem	set ^"template=for %%# in (1 2) do if %%#==2 (%\n%
rem		setlocal EnableDelayedExpansion%\n%
rem		rem set "this=!this!"%\n%
rem		echo this = !this!%\n%
rem		 set "!this!_argv=!argv:~1!"%\n%
rem		call set "_argv="%%!this!_file%%" !argv!"%\n%
rem		set "argc=0"%\n%
rem		for %%C in (!_argv!) do set "_argv_=!_argv_!;%%C" ^& set "!this!_argv!argc!=%%C" ^& set /a argc+=1 %\n%
rem		set /a "argc-=1"%\n%
rem		set "!this!_argc=!argc!"%\n%
rem		call echo !this!_argv = '%%!this!_argv%%'%\n%
rem		call echo !this!_argc = '%%!this!_argc%%'%\n%
rem		for /L %%n in (0 1 !argc!) do (%\n%
rem		  call echo !this!_argv%%n = '%%!this!_argv%%n%%'%\n%
rem		)%\n%
rem		FOR /F "usebackq tokens=1-20 delims=;" %%0 IN ('!_argv_!') do (%\n%
rem		FOR /F "delims=" %%* IN ("!argv:~1!") do (%\n%"
rem
rem	set ^"templateB=))%\n%
rem		for /F "delims=" %%a in ('set !this!_') do (%\n%
rem		if "!this!" equ "%~n0" endlocal%\n%
rem		if defined this endlocal%\n%
rem			set "%%a"%\n%
rem		)%\n%
rem	) else setlocal DisableDelayedExpansion ^& set argv="

	rem https://www.dostips.com/forum/viewtopic.php?f=3&t=2128&sid=938ec204d04c1482fc7c39b6a457b052
	rem setlocal EnableDelayedExpansion
	set "this=%~2"
	call :readFile "%~1" :%~2
	rem  echo this = %this%
	set "%~2_file=%~1"
	set %~2=!filedata!
	rem set %~2=!filedata:%%%%=%%!
	rem  echo %~2='!filedata:%%%%=%%!'
	rem  echo template='!template!'
	rem  set "_MACRO_=!template:template=%~2!!filedata:%%%%=%%!!templateB:template=%~2!"
	rem  set "_MACRO_=!template!!filedata:%%%%=%%!!templateB:template=%this%!"
	rem set "filedata=!filedata:%%setlocal%%=%setlocal%!"
	rem set "filedata=!filedata:%%dk_call%%=%dk_call%!"
	rem set "filedata=!filedata:%%endfuncion%%=%endfuncion%!"
	rem set "filedata=!filedata:%%%%=%%!"
	rem set "_MACRO_=!template!!filedata!!templateB:template=%this%!"
	rem set "_MACRO_=!template!!filedata!!templateB!"
	set "_MACRO_=!template2!!filedata!!template2B!"
	rem set "_MACRO_=!_MACRO_:%%%%=%%!"
	
	
rem	echo.
rem	echo ########### call %~2 #################
rem	echo.
rem	for /f "tokens=3*" %%a in ("%*") do (
rem		set args=%%a
rem	)
rem	%_MACRO_% %args%
						rem  call :readMacro "%UserProfile%\Digital Knob\Development\DKBatch\functions\dk_selectFolder.cmd" dk_selectFolder
rem	echo.
rem	echo ########### end %~2 ##################
rem	echo %~2_argv  = '!%~2_argv!'
rem	echo %~2_argc  = '!%~2_argc!'
rem	echo %~2_argv0 = '!%~2_argv0!'
rem	echo %~2_argv1 = '!%~2_argv1!'
rem	echo %~2_argv2 = '!%~2_argv2!'
rem	echo %~2_argv3 = '!%~2_argv3!'
rem	echo.
rem	echo this = %this%
rem	echo %%this%%_argv  = '!%this%_argv!'
rem	echo %%this%%_argc  = '!%this%_argc!'
rem	echo %%this%%_argv0 = '!%this%_argv0!'
rem	echo %%this%%_argv1 = '!%this%_argv1!'
rem	echo %%this%%_argv2 = '!%this%_argv2!'
rem	echo %%this%%_argv3 = '!%this%_argv3!'

	rem set "%~2=!template2!!filedata!!template2B:template=%this%!"
	set "%~2=!_MACRO_!"
	echo.	###1111########## %~2 MACRO = ##########1111##########
	echo !%this%!
	rem echo !%this%:%%%%=%%!
	echo.	#####1111##############################1111###########

	%returnVar% _MACRO_
exit /b
:dk_loadMacro_END


:readFile file start_string
	set "filedata="
	set "read="
	<"%~1" (call :readLoop "%~2")
	exit /b
:readLoop	
	set "line="
	set /p line=
	if "!line!" equ "%~1" set read=1
	if "!line!" equ "^!endfunction^!" exit /b
	if "!line!" equ "%%endfunction%%" exit /b
	if "!line!" equ "%~1_END" exit /b
	if "!line!" equ ":#EOF#" exit /b
	if "%read%" equ "1" set filedata=!filedata!!line!!LF!
	goto :readLoop
	exit /b
:readFile_END


:dk_call2_FUNC
	setlocal enableDelayedExpansion
	echo.
	echo %ESC%[35m:dk_call2_FUNC^> '%*'%ESC%[0m
	%* && (
		echo %ESC%[32mOK%ESC%[0m
		echo.
	) || (
		echo %ESC%[31mERROR:!errorlevel! @ %~nx0 ^>%*
		echo.
	)
:dk_call2_FUNC_END
exit /b

:dk_call2_MACRO
	if DEFINED dk_call2_MACRO (
		echo %ESC%[31mERROR:1 @ %~nx0 ^>:dk_call2_MACRO ALREADY DEFINED%ESC%[0m
		echo.
		exit /b 1
	) else set ^"dk_call2_MACRO=for %%# in (1 2) do if %%#==2 (%\n%
		setlocal EnableDelayedExpansion%\n%
		if defined argv (%\n%
			set argv=!argv:~1!%\n%
			for /F "delims=" %%* in ("!argv!") do (%\n%
				endlocal%\n%
				endlocal%\n%
				rem ###############################################%\n%
				echo. ^&echo %ESC%[35m:dk_call2_MACRO^^^> '%%*'%ESC%[0m%\n%
				%%* ^&^& ^(%\n%
					echo %ESC%[32mOK%ESC%[0m%\n%
					echo.%\n%
				^) ^|^| ^(%\n%
					echo %ESC%[31mERROR:!errorlevel! @ %~nx0 ^^^>%%*%ESC%[0m%\n%
					echo.%\n%
				^)%\n%
				rem ###############################################%\n%
			)%\n%
		) else (%\n%
			echo %ESC%[31mERROR:1 @ %~nx0 ^^^>dk_call2 EMPTY COMMAND%ESC%[0m%\n%
			echo.%\n%
		)%\n%
	) ELSE setlocal DisableDelayedExpansion ^& set argv="
exit /b
:dk_call2_MACRO_END


:main  
	call :dk_call2_FUNC 	echo ':dk_call2_FUNC' called directly with 'call' & echo.
	
	rem call :dk_call2_MACRO
	rem %dk_call2_MACRO% echo '%%dk_call2_MACRO%%' called via macro variable & echo.
	
	echo.	#####2222######## dk_call2_FUNC MACRO = ############2222########
	echo this = !this!
	echo !dk_call2_FUNC:%%%%=%%!
	echo.	########2222###########################################2222###########
	
	%dk_call2_FUNC% echo 'dk_call2_FUNC' called via macro loaded from function
	
	rem %dk_call2_MACRO% setlocal EnableDelayedExpansion
	rem call :dk_call2_FUNC   set var=content
	rem %dk_call2_MACRO% call :dk_call2_MACRO
	
	rem call :dk_call2_FUNC ver
	rem %dk_call2_MACRO% ver
	rem %dk_call2_FUNC% ver
	
	rem %dk_call2_MACRO% ver /?
	rem call :dk_call2_FUNC dir *.*
	rem %dk_call2_MACRO% echo %var% !var! 
	rem %dk_call2_MACRO% pause
	rem %dk_call2_MACRO% exit /b
	  
	pause
exit /b
:main_END
:#EOF#