@echo off

:main
  call :readMacro abc "1 2 3"
  pause
:mainEnd
exit /b %errorlevel%

:readMacroABC
  echo  * = '%*'
  echo  0 = '%0'
  echo ~0 = '%~0'
  echo  1 = '%1'
  echo ~1 = '%~1'
  echo  2 = '%2'
  echo ~2 = '%~2'
  echo  3 = '%3'
  echo ~3 = '%~3'
  echo  4 = '%4'
  echo ~4 = '%~4'
  echo  5 = '%5'
  echo ~5 = '%~5'
  echo  6 = '%6'
  echo ~6 = '%~6'
  echo  7 = '%7'
  echo ~7 = '%~7'
  echo error_level = '%errorlevel%'
:readMacroABC_END


:simple_func
  echo  0 = '%0'
  echo ~0 = '%~0'
  echo  1 = '%1'
  echo ~1 = '%~1'
  echo  2 = '%2'
  echo ~2 = '%~2'
  echo  3 = '%3'
  echo ~3 = '%~3'
  echo  4 = '%4'
  echo ~4 = '%~4'
  echo  5 = '%5'
  echo ~5 = '%~5'
  echo  6 = '%6'
  echo ~6 = '%~6'
  echo  7 = '%7'
  echo ~7 = '%~7'
  echo  * = '%*'
  echo error_level = '%errorlevel%'
:simple_func_END

echo after
pause
goto:eof





:macroB
for %%# in (1 2) do if %%#==2 (
    setlocal EnableDelayedExpansion
    set "this=macroB"
    set "!this!_argv0=MacroFile.cmd"
    set "!this!_argv=!argv:~1!"
    set "argc=1"
    for %%C in (!argv!) do set "!this!_argv!argc!=%%~C" & set /a argc+=1
    set /a "argc-=1"
    set "!this!_argc=!argc!"
    call echo !this!_argv = '%%!this!_argv%%'
    call echo !this!_argc = '%%!this!_argc%%'
    for /L %%n in (0 1 !argc!) do (
      call echo !this!_argv%%n = '%%!this!_argv%%n%%'
    )
    for /F "delims=" %%a in ('set !this!_') do (
      if "!this!" equ "macroB" endlocal
      set "%%a"
    )
) else set argv=
rem :macroB_END

:#EOF#


:macroC
for %%# in (1 2) do if %%#==2 (
    setlocal EnableDelayedExpansion
    set "this=macroB"
    set "!this!_argv0=MacroFile.cmd"
    set "!this!_argv=!argv:~1!"
    set "argc=1"
    for %%C in (!argv!) do set "!this!_argv!argc!=%%~C" & set /a argc+=1
    set /a "argc-=1"
    set "!this!_argc=!argc!"
    call echo !this!_argv = '%%!this!_argv%%'
    call echo !this!_argc = '%%!this!_argc%%'
    for /L %%n in (0 1 !argc!) do (
      call echo !this!_argv%%n = '%%!this!_argv%%n%%'
    )
    for /F "delims=" %%a in ('set !this!_') do (
      if "!this!" equ "macroB" endlocal
      set "%%a"
    )
) else set argv=
:macroC_END




pause
:#EOF#
