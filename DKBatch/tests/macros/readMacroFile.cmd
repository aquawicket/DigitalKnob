@echo off

setlocal DisableDelayedExpansion
(set LF=^
%=Do not remove this line=%
)
set ^"\n=^^^%LF%%LF%^%LF%%LF%^^"
set ^"macroA=for %%# in (1 2) do if %%#==2 (                                     %\n%
    setlocal EnableDelayedExpansion                                           %\n%
    set "this=macroA"                                                            %\n%
    set "!this!_argv0=%~0"                                                       %\n%
    set "!this!_argv=!argv:~1!"                                                  %\n%
    set "argc=1"                                                                 %\n%
    for %%C in (!argv!) do set "!this!_argv!argc!=%%~C" ^& set /a argc+=1       %\n%
    set /a "argc-=1"                                                             %\n%
    set "!this!_argc=!argc!"                                                     %\n%
    call echo !this!_argv = '%%!this!_argv%%'                                   %\n%
    call echo !this!_argc = '%%!this!_argc%%'                                   %\n%
    for /L %%n in (0 1 !argc!) do (                                             %\n%
      call echo !this!_argv%%n = '%%!this!_argv%%n%%'                           %\n%
    )                                                                            %\n%
    for /F "delims=" %%a in ('set !this!_') do (                                %\n%
      if "!this!" equ "macroA" endlocal                                         %\n%
      set "%%a"                                                                  %\n%
    )                                                                            %\n%
) else set argv="

set ^"template=for %%# in (1 2) do if %%#==2 (%\n%
    setlocal EnableDelayedExpansion%\n%
    set "this=template"%\n%
     set "template_argv=!argv:~1!"%\n%
    set "_argv=%0 !argv!"%\n%
    set "argc=0"%\n%
    for %%C in (!_argv!) do set "_argv_=!_argv_!;%%C" ^& set "template_argv!argc!=%%C" ^& set /a argc+=1 %\n%
    set /a "argc-=1"%\n%
    set "template_argc=!argc!"%\n%
    call echo template_argv = '%%template_argv%%'%\n%
    call echo template_argc = '%%template_argc%%'%\n%
    for /L %%n in (0 1 !argc!) do (%\n%
      call echo template_argv%%n = '%%template_argv%%n%%'%\n%
    )%\n%
    FOR /F "usebackq tokens=1-9 delims=;" %%0 IN ('!_argv_!') do (%\n%
    FOR /F "delims=" %%* IN ("!argv:~1!") do (%\n%"
    

    set ^"templateB=))%\n%
    for /F "delims=" %%a in ('set !this!_') do (%\n%
    if "!this!" equ "template" endlocal%\n%
        set "%%a"%\n%
    )%\n%
) else set argv="



:main
  rem https://www.dostips.com/forum/viewtopic.php?f=3&t=2128&sid=938ec204d04c1482fc7c39b6a457b052
  setlocal EnableDelayedExpansion
  
  echo ############ macroA ############
  echo macroA='!macroA!'
  echo ################################
  %macroA% abc "1 2 3"
  
  echo.
  echo.
  echo ############ :macroB ############
  <"%~dp0MacroFile.cmd" (call :readFile :macroB)
  set macroB=!filedata:%%%%=%%!
  set ^"macroB=!macroB:~0,-1!"
  echo macroB='!macroB!'
  echo.
  %macroB% 123 "a b c"
  echo ################################
  
  echo.
  echo.
  echo ############ :macroC ############
  <"%~dp0MacroFile.cmd" (call :readFile :macroC)
  set macroC=!filedata:%%%%=%%!
  set ^"macroC=!macroC:~0,-1!"
  echo macroC='!macroC!'
  echo.
  %macroC% happy "birthday"
  echo ################################
  
  echo.
  echo.
  echo ############ :simple_func ############
  <"%~dp0MacroFile.cmd" (call :readFile :simple_func)
  set "simple_func_file=%~dp0MacroFile.cmd"
rem  set simple_func=!filedata:%%%%=%%!
  echo filedata='!filedata:%%%%=%%!'
  echo template='!template!'
  set "macro=!template:template=simple_func!!filedata:%%%%=%%!!templateB:template=simple_func!"
  echo macro='!macro!'
  echo.
  %macro% abc "9 8 7" arg3 "arg 4"
  echo ################################
  echo simple_func_argv  = '%simple_func_argv%'
  echo simple_func_argc  = '%simple_func_argc%'
  echo simple_func_argv0 = '%simple_func_argv0%'
  echo simple_func_argv1 = '%simple_func_argv1%'
  echo simple_func_argv2 = '%simple_func_argv2%'
  echo simple_func_argv3 = '%simple_func_argv3%'
  echo simple_func_argv4 = '%simple_func_argv4%'
  echo simple_func_argv5 = '%simple_func_argv5%'
  echo simple_func_argv6 = '%simple_func_argv6%'
  echo simple_func_argv7 = '%simple_func_argv7%'
  echo simple_func_argv8 = '%simple_func_argv8%'
  echo simple_func_argv9 = '%simple_func_argv9%'
  pause
  
  echo.
  echo.
  echo ############ :readMacro ############
  call :readMacro "%~dp0MacroFile.cmd" readMacroABC
  echo ####################################
  echo readMacroABC_argv  = '!readMacroABC_argv!'
  echo readMacroABC_argc  = '!readMacroABC_argc!'
  echo readMacroABC_argv0 = '!readMacroABC_argv0!'
  echo readMacroABC_argv1 = '!readMacroABC_argv1!'
  echo readMacroABC_argv2 = '!readMacroABC_argv2!'
  echo readMacroABC_argv3 = '!readMacroABC_argv3!'
  echo readMacroABC_argv4 = '!readMacroABC_argv4!'
  echo readMacroABC_argv5 = '!readMacroABC_argv5!'
  echo readMacroABC_argv6 = '!readMacroABC_argv6!'
  echo readMacroABC_argv7 = '!readMacroABC_argv7!'
  echo readMacroABC_argv8 = '!readMacroABC_argv8!'
  echo readMacroABC_argv9 = '!readMacroABC_argv9!'
  echo.
  echo this = %this%
  echo %%this%%_argv  = !%this%_argv!
  echo %%this%%_argc  = '!%this%_argc!'
  echo %%this%%_argv0 = '!%this%_argv0!'
  echo %%this%%_argv1 = '!%this%_argv1!'
  echo %%this%%_argv2 = '!%this%_argv2!'
  echo %%this%%_argv3 = '!%this%_argv3!'
  echo %%this%%_argv4 = '!%this%_argv4!'
  echo %%this%%_argv5 = '!%this%_argv5!'
  echo %%this%%_argv6 = '!%this%_argv6!'
  echo %%this%%_argv7 = '!%this%_argv7!'
  echo %%this%%_argv8 = '!%this%_argv8!'
  echo %%this%%_argv9 = '!%this%_argv9!'
  
  
  pause
exit /b 0

:readFile
  set "filedata="
  set "read="
  :readLoop
	set "line="
	set /p line=
  if "!line!" equ "%%endfunction%%" exit /b
	if "!line!" equ "%~1_END" exit /b
	if "!line!" equ ":#EOF#" exit /b
	if "%read%" equ "1" set filedata=!filedata!!line!!LF!
	if "!line!" equ "%~1" set read=1
goto :readLoop

:readMacro
  ::FIXME - the two hardcoded 'readMacro' variables are our problem. They need to be dynamic
  echo ############ %~2 ############
  echo  "%~1" (call :readFile :%~2)
  <"%~1" (call :readFile :%~2)
  set "this=%~2"
  echo this = %this%
  set "%~2_file=%~1"
  set %~2=!filedata:%%%%=%%!
  echo %~2='!filedata:%%%%=%%!'
  echo template='!template!'
  set "_MACRO_=!template:template=%~2!!filedata:%%%%=%%!!templateB:template=%~2!"
  echo %this%='!_MACRO_!'
  echo.
  %_MACRO_% abc "9 8 7" arg3 "arg 4"
  echo ################################
exit /b %errorlevel%

