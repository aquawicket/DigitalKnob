::RETURN.BAT Version 3.0
@if "%~2" equ "" (goto :return.special) else goto :return
:::
:::call RETURN  ValueVar  ReturnVar  [ErrorCode]
:::  Used by batch functions to EXIT /B and safely return any value across the
:::  ENDLOCAL barrier.
:::    ValueVar  = The name of the local variable containing the return value.
:::    ReturnVar = The name of the variable to receive the return value.
:::    ErrorCode = The returned ERRORLEVEL, defaults to 0 if not specified.
:::
:::call RETURN "ValueVar1 ValueVar2 ..." "ReturnVar1 ReturnVar2 ..." [ErrorCode]
:::  Same as before, except the first and second arugments are quoted and
:::  space delimited lists of variable names.
:::
:::  Note that the total length of all assignments (variable names and values)
:::  must be less then 3.8k bytes. No checks are performed to verify that all
:::  assignments fit within the limit. Variable names must not contain space,
:::  tab, comma, semicolon, caret, asterisk, question mark, or exclamation point.
:::
:::call RETURN  init
:::  Defines return.LF and return.CR variables. Not required, but should be
:::  called once at the top of your script to improve performance of RETURN.
:::
:::return /?
:::  Displays this help
:::
:::return /V
:::  Displays the version of RETURN.BAT
:::
:::
:::RETURN.BAT was written by Dave Benham and DosTips user jeb, and was originally
:::posted within the folloing DosTips thread:
:::  http://www.dostips.com/forum/viewtopic.php?f=3&t=6496
:::
::==============================================================================
::  If the code below is copied within a script, then the :return.special code
::  can be removed, and your script can use the following calls:
::
::    call :return   ValueVar  ReturnVar  [ErrorCode]
::
::    call :return.init
::

:return  ValueVar  ReturnVar  [ErrorCode]
:: Safely returns any value(s) across the ENDLOCAL barrier. Default ErrorCode is 0
setlocal enableDelayedExpansion
if not defined return.LF call :return.init
if not defined return.CR call :return.init
set "return.normalCmd="
set "return.delayedCmd="
set "return.vars=%~2"
for %%a in (%~1) do for /f "tokens=1*" %%b in ("!return.vars!") do (
  set "return.normal=!%%a!"
  if defined return.normal (
    set "return.normal=!return.normal:%%=%%3!"
    set "return.normal=!return.normal:"=%%4!"
    for %%C in ("!return.LF!") do set "return.normal=!return.normal:%%~C=%%~1!"
    for %%C in ("!return.CR!") do set "return.normal=!return.normal:%%~C=%%2!"
    set "return.delayed=!return.normal:^=^^^^!"
  ) else set "return.delayed="
  if defined return.delayed call :return.setDelayed
  set "return.normalCmd=!return.normalCmd!&set "%%b=!return.normal!"^!"
  set "return.delayedCmd=!return.delayedCmd!&set "%%b=!return.delayed!"^!"
  set "return.vars=%%c"
)
set "err=%~3"
if not defined err set "err=0"
for %%1 in ("!return.LF!") do for /f "tokens=1-3" %%2 in (^"!return.CR! %% "") do (
  (goto) 2>nul
  (goto) 2>nul
  if "^!^" equ "^!" (%return.delayedCmd:~1%) else %return.normalCmd:~1%
  if %err% equ 0 (call ) else if %err% equ 1 (call) else cmd /c exit %err%
)

:return.setDelayed
set "return.delayed=%return.delayed:!=^^^!%" !
exit /b

:return.special
@if /i "%~1" equ "init" goto return.init
@if "%~1" equ "/?" (
  for /f "tokens=* delims=:" %%A in ('findstr "^:::" "%~f0"') do @echo(%%A
  exit /b 0
)
@if /i "%~1" equ "/V" (
  for /f "tokens=* delims=:" %%A in ('findstr /rc:"^::RETURN.BAT Version" "%~f0"') do @echo %%A
  exit /b 0
)
@>&2 echo ERROR: Invalid call to RETURN.BAT
@exit /b 1


:return.init  -  Initializes the return.LF and return.CR variables
set ^"return.LF=^

^" The empty line above is critical - DO NOT REMOVE
for /f %%C in ('copy /z "%~f0" nul') do set "return.CR=%%C"
exit /b 0