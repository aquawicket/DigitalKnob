:dk_loadMacro
	echo dk_loadMacro %*
	if "!!"=="" (
		echo ERROR: Delayed Expansion must be disabled while defining macros
		pause
		exit /b
	)

	set ^"@wrapper_start=for %%# in (1 2) do if %%#==2 (%\n%
		setlocal EnableDelayedExpansion%\n%
		echo argv = !argv!%\n%
		if defined argv (%\n%
			set argv=!argv:~1!%\n%
			for /F "delims=" %%* in ("!argv!") do (%\n%
			%endlocal%%\n%
			%endlocal%%\n%"

	
	set ^"@wrapper_end=)%\n%
		) else (%\n%
			echo %ESC%[31mERROR:1 @ %~nx0 ^^^>dk_call2 EMPTY COMMAND%ESC%[0m%\n%
			echo.%\n%
		)%\n%
	) else setlocal enableDelayedExpansion^&setlocal^&set argv="


	call :readFile "%~1" :%~2
	call %~dp0printMacro.cmd filedata
	set "@%~2=%wrapper_start%%filedata%%wrapper_end%"
	rem set "@%~2=!wrapper_start!!filedata!!wrapper_end!"
exit /b
:dk_loadMacro_END
	
	
:readFile file start_string
setlocal enableDelayedExpansion
(set \n=^^^
%= DO NOT REMOVE THIS LINE =%
)
	set "filedata="
	set "read="
	<"%~1" (call :readLoop "%~2")
	exit /b
:readLoop	
	set "line="
	set /p line=
	if "%line%" equ "%~1" set read=1
	if "%line%" equ "%~1_END" exit /b
	if "%read%" equ "1" (
		set "filedata=%filedata%%line%!LF!"
	)
	goto :readLoop
	exit /b
:readFile_END


::	echo :dk_loadMacro %*
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
rem		if "!this!" equ "%~n0" %endlocal%%\n%
rem		if defined this %endlocal%%\n%
rem			set "%%a"%\n%
rem		)%\n%
rem	) else setlocal DisableDelayedExpansion ^& set argv="

	rem https://www.dostips.com/forum/viewtopic.php?f=3&t=2128&sid=938ec204d04c1482fc7c39b6a457b052
	rem setlocal EnableDelayedExpansion
	
	rem  echo this = %this%
	
	
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




