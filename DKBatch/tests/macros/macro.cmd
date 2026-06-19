@Echo off


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






setlocal DisableDelayedExpansion
set LF=^


::Above 2 blank lines are required - do not remove
set ^"\n=^^^%LF%%LF%^%LF%%LF%^^"

set ^"macrofunc=for %%# in (1 2) do if %%#==2 (                                  %\n%
    setlocal EnableDelayedExpansion                                           %\n%
    set "this=macrofunc"                                                         %\n%
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
      if "!this!" equ "macrofunc" endlocal                                     %\n%
      set "%%a"                                                                  %\n%
    )                                                                            %\n%
) else set argv="


setlocal enableDelayedExpansion
echo ######### macrofunc #########
echo !macrofunc:%%=%%%%!
echo #############################
echo.
%macrofunc% arg1 "arg 2" arg3
  echo.
  echo macrofunc_argv = '%macrofunc_argv%'
  echo macrofunc_argc = '%macrofunc_argc%'
  echo macrofunc_argv0 = '%macrofunc_argv0%'
  echo macrofunc_argv1 = '%macrofunc_argv1%'
  echo macrofunc_argv2 = '%macrofunc_argv2%'
  echo macrofunc_argv3 = '%macrofunc_argv3%'
endlocal
pause





