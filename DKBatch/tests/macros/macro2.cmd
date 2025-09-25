@echo off
setlocal

set LF=^


::Above 2 blank lines are required - do not remove

set ^"\n=^^^%LF%%LF%^%LF%%LF%^^"

set callMacro=for /f "tokens=1-26" %%a in

set macro=do (%\n%
  setLocal enableDelayedExpansion %\n%
  echo in macro prior to loop: a=%%a %\n%
  for /l %%a in (1,1,3) do echo inside inner macro loop: a=%%a %\n%
  echo in macro after loop: a=%%a %\n%
  set "rtn=Return Value" %\n%
  echo variable in macro to return: rtn=!rtn! %\n%
  for /f "delims=" %%v in ("!rtn!") do set "%%~a=%%v" %\n%
)

set macro

set var=A B C
echo before call to macro: var=%var%
%callMacro% ("var") %macro%
echo after call to macro: var=%var%
pause