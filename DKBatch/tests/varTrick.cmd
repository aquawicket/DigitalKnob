@echo off
for %%# in (1 2) do if %%#==2 (
    setlocal EnableDelayedExpansion
    set "this=myFunc"
    echo this = !this!
    set "!this!_argv0=%~0"
    set "!this!_argv=!argv:~1!"
    set "argc=1" 
    for %%v in (!argv!) do set "!this!_argv!argc!=%%~v" & set /a argc+=1
    set /a "argc-=1"
    set "!this!_argc=!argc!" 
    call echo !this!_argv = '%%!this!_argv%%'
    call echo !this!_argc = '%%!this!_argc%%'
    for /L %%n in (0 1 !argc!) do (
      call echo !this!_argv%%n = '%%!this!_argv%%n%%'
    )
    for /F "delims=" %%a in ('set !this!_') do (
      if "!this!" equ "myFunc" endlocal
      set "%%a"
    )
) else set argv= arg1 "arg 2" arg3

pause