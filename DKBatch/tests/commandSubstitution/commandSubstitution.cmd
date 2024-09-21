@echo off

:: display the delayed expansion state
set "if_DE=if "!DE!" equ """
set "if_NDE=if "!DE!" neq """
set "_DE_=%if_DE% (echo delayed expansion ON) else (echo delayed expansion OFF)" 



:: TestA
:: The simplest form of command substitution.
:: The macroA variable is set to invoke the command and then set itself to the result
echo:
%_DE_%
set macroA=&for /f "usebackq tokens=*" %%a in (`ver`) do echo %%a > 0
echo macroA = %macroA%


:: TestB
:: The same test as above, but with delayed expansion enabled
echo:
setlocal enabledelayedexpansion
%_DE_%
set macroB=&for /f "usebackq tokens=*" %%a in (`ver`) do set "macroB=%%a"
echo macroB = %macroB%
endlocal


:: TestC
:: Same test with a different command
echo:
%_DE_%
set macroC=&for /f "usebackq tokens=*" %%a in (`time /t`) do set "macroC=%%a"
echo macroC = %macroC% w/trailing text


:: TestD
:: Same test calling another batch file
echo:
%_DE_%
set macroD=&for /f "usebackq tokens=*" %%a in (`bat_echo.cmd`) do set "macroD=%%a"
echo macroD = %macroD%


:: TestE
:: Chain multiple subs together 
::echo:
::%_DE_%
::set hour=&for /f "usebackq tokens=*" %%a in (`bat_echo.cmd hour`) do set "hour=%%a"
::set minute=&for /f "usebackq tokens=*" %%a in (`bat_echo.cmd minute`) do set "minute=%%a"
::set second=&for /f "usebackq tokens=*" %%a in (`bat_echo.cmd second`) do set "second=%%a"
::echo time = %hour%:%minute%:%second%
echo:
set macroGetTime=&(%\n%
  setlocal enableDelayedExpansion%\n%
  set "t=0"%\n%
  for /f "tokens=1-4 delims=:." %%A in ("!time: =0!") do set /a "t=(((1%%A*60)+1%%B)*60+1%%C)*100+1%%D-36610100"%\n%
  for %%v in (!t!) do endlocal ^&set "%%~A=%%v"%\n%
)

%macroGetTime% arg1 arg2
echo time = %time% 



pause