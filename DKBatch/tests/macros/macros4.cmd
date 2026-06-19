@echo off
setlocal

::------------------------------------------
:: DEFINE MACROS

set LF=^


::Above 2 blank lines are required - do not remove

set ^"\n=^^^%LF%%LF%^%LF%%LF%^^"

set forEntireLine=^^^^^^^"eol^^^^=^^^^^^^%LF%%LF%^%LF%%LF%^^^%LF%%LF%^%LF%%LF%^^^^ delims^^^^=^^^^^^^"

set callMacro=for /f "tokens=1-26" %%a in

set macroNum2Hex=do (%\n%
  setlocal enableDelayedExpansion%\n%
  if defined hex set "hex="%\n%
  set /a "dec=(%%~a)"%\n%
  set "map=0123456789ABCDEF"%\n%
  for /l %%n in (1,1,8) do (%\n%
    set /a "d=dec&15,dec>>=4"%\n%
    for %%d in (!d!) do set "hex=!map:~%%d,1!!hex!"%\n%
  )%\n%
  for %%v in (!hex!) do endlocal^&if "%%~b" neq "" (set "%%~b=%%v") else echo %%v%\n%
)

set macroStrLen=do (%\n%
  setlocal enableDelayedExpansion%\n%
  set "str=A!%%~a!"%\n%
  set "len=0"%\n%
  for /l %%A in (12,-1,0) do (%\n%
    set /a "len|=1<<%%A"%\n%
    for %%B in (!len!) do if "!str:~%%B,1!"=="" set /a "len&=~1<<%%A"%\n%
  )%\n%
  for %%v in (!len!) do endlocal^&if "%%~b" neq "" (set "%%~b=%%v") else echo %%v%\n%
)

set macroToLower=do (%\n%
  setlocal enableDelayedExpansion%\n%
  set "str=!%%~a!"%\n%
  for %%A in (%\n%
    "A=a" "B=b" "C=c" "D=d" "E=e" "F=f" "G=g" "H=h" "I=i"%\n%
    "J=j" "K=k" "L=l" "M=m" "N=n" "O=o" "P=p" "Q=q" "R=r"%\n%
    "S=s" "T=t" "U=u" "V=v" "W=w" "X=x" "Y=y" "Z=z" "Ä=ä"%\n%
    "Ö=ö" "Ü=ü"%\n%
  ) do set "str=!str:%%~A!"%\n%
  for /f %forEntireLine% %%v in ("!str!") do endlocal^&set "%%~a=%%~v"%\n%
)

set macroGetTime=do (%\n%
  setlocal enableDelayedExpansion%\n%
  set "t=0"%\n%
  for /f "tokens=1-4 delims=:." %%A in ("!time: =0!") do set /a "t=(((1%%A*60)+1%%B)*60+1%%C)*100+1%%D-36610100"%\n%
  for %%v in (!t!) do endlocal^&set "%%~a=%%v"%\n%
)

set macroDiffTime=do (%\n%
  setlocal enableDelayedExpansion%\n%
  set /a "DD=(%%~b)-(%%~a)"%\n%
  if !DD! lss 0 set /a "DD+=24*60*60*100"%\n%
  set /a "HH=DD/360000, DD-=HH*360000, MM=DD/6000, DD-=MM*6000, SS=DD/100, DD-=SS*100"%\n%
  if "!HH:~1!"=="" set "HH=0!HH!"%\n%
  if "!MM:~1!"=="" set "MM=0!MM!"%\n%
  if "!SS:~1!"=="" set "SS=0!SS!"%\n%
  if "!DD:~1!"=="" set "DD=0!DD!"%\n%
  for %%v in (!HH!:!MM!:!SS!.!DD!) do endlocal^&if "%%~c" neq "" (set "%%~c=%%v") else echo %%v%\n%
)

:: END MACROS
::------------------------------------------

set "txt=;I Wonder HOW long this text string is?"

::==== Test Macros =============================
echo --------------------------
echo Macro results:
set result=
%callMacro% ("56789") %macroNum2Hex%
%callMacro% ("-1 result") %macroNum2Hex%
set result
%callMacro% ("t1") %macroGetTime%
for /l %%n in (1,1,255) do %callMacro% ("%%n result") %macroNum2Hex%
%callMacro% ("t2") %macroGetTime%
%callMacro% ("t1 t2 timeMacroNum2Hex") %macroDiffTime%
set result
set "result=%txt%"
%callMacro% ("t1") %macroGetTime%
for /l %%n in (1,1,255) do %callMacro% ("result") %macroToLower%
%callMacro% ("t2") %macroGetTime%
%callMacro% ("t1 t2 timeMacroToLower") %macroDiffTime%
set result
%callMacro% ("txt") %macroStrLen%
%callMacro% ("t1") %macroGetTime%
for /l %%n in (1,1,255) do %callMacro% ("txt result") %macroStrLen%
%callMacro% ("t2") %macroGetTime%
%callMacro% ("t1 t2 timeMacroStrLen") %macroDiffTime%
set result

::===== Test Function Calls ====================
echo --------------------------
echo Call results:
set result=
call :num2hex 56789
call :num2hex -1 result
set result
%callMacro% ("t1") %macroGetTime%
for /l %%n in (1,1,255) do call :num2hex %%n result
%callMacro% ("t2") %macroGetTime%
%callMacro% ("t1 t2 timeNum2Hex") %macroDiffTime%
set result
set "result=%txt%"
%callMacro% ("t1") %macroGetTime%
for /l %%n in (1,1,255) do call :toLower result
%callMacro% ("t2") %macroGetTime%
%callMacro% ("t1 t2 timeToLower") %macroDiffTime%
set result
call :strLen txt
%callMacro% ("t1") %macroGetTime%
for /l %%n in (1,1,255) do call :strLen txt result
%callMacro% ("t2") %macroGetTime%
%callMacro% ("t1 t2 timeStrLen") %macroDiffTime%
set result

::==== Show timings =============================
echo -------------------------
echo:num2Hex macro time x 255 = %timeMacroNum2Hex%
echo:         call time x 255 = %timeNum2Hex%
echo:
echo:toLower macro time x 255 = %timeMacroToLower%
echo:         call time x 255 = %timeToLower%
echo:
echo:strLen  macro time x 255 = %timeMacroStrLen%
echo:         call time x 255 = %timeStrLen%

exit /b

::------------------------------------------------------
:: Begin function definitions

:num2hex    NumVal [RtnVar]
  setlocal enabledelayedexpansion
  set /a dec=%~1 2>nul
  if defined hex set hex=
  set "map=0123456789ABCDEF"
  for /l %%n in (1,1,8) do (
      set /a "d=dec&15,dec>>=4"
      for %%d in (!d!) do set "hex=!map:~%%d,1!!hex!"
  )
  endlocal&if "%~2" neq "" (set %~2=%hex%) else echo:%hex%
exit /b

:strLen string len -- returns the length of a string
  setlocal enabledelayedexpansion
  set "str=A!%~1!"
  set "len=0"
  for /l %%A in (12,-1,0) do (
    set /a "len|=1<<%%A"
    for %%B in (!len!) do if "!str:~%%B,1!"=="" set /a "len&=~1<<%%A"
  )
  endlocal&if "%~2" neq "" (set /a %~2=%len%) else echo:%len%
exit /b

:toLower strVar
  setlocal enabledelayedexpansion
  set "str=!%~1!"
  for %%A in (
    "A=a" "B=b" "C=c" "D=d" "E=e" "F=f" "G=g" "H=h" "I=i"
    "J=j" "K=k" "L=l" "M=m" "N=n" "O=o" "P=p" "Q=q" "R=r"
    "S=s" "T=t" "U=u" "V=v" "W=w" "X=x" "Y=y" "Z=z" "Ä=ä"
    "Ö=ö" "Ü=ü"
   ) do set str=!str:%%~A!
  endlocal & set %~1=%str%
exit /b