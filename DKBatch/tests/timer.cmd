@echo off&::########################################## DigitalKnob DKBatch ########################################################################
::if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
::if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::#################################################################################################################################################


setlocal
 
::------------------------------------------
:: TIMER MACROS
 
set callMacro=for /f "tokens=1-26" %%a in

set macroGetTime=do^
  setlocal enableDelayedExpansion^
  ^&set "t=0"^
  ^&(for /f "tokens=1-4 delims=:." %%A in ("!time: =0!") do set /a "t=(((1%%A*60)+1%%B)*60+1%%C)*100+1%%D-36610100")^
  ^&(for %%v in (!t!) do endlocal^&set %%~a=%%v)

set macroDiffTime=do^
  setlocal enableDelayedExpansion^
  ^&set /a "DD=(%%~b)-(%%~a)"^
  ^&(if !DD! lss 0 set /a "DD+=24*60*60*100")^
  ^&set /a "HH=DD/360000, DD-=HH*360000, MM=DD/6000, DD-=MM*6000, SS=DD/100, DD-=SS*100"^
  ^&(if "!HH:~1!"=="" set "HH=0!HH!")^
  ^&(if "!MM:~1!"=="" set "MM=0!MM!")^
  ^&(if "!SS:~1!"=="" set "SS=0!SS!")^
  ^&(if "!DD:~1!"=="" set "DD=0!DD!")^
  ^&(for %%v in (!HH!:!MM!:!SS!.!DD!) do endlocal^&if "%%~c" neq "" (set %%~c=%%v) else echo %%v)

echo starting timer
%callMacro% ("t1") %macroGetTime%
ping 127.0.0.1 1>nul
%callMacro% ("t2") %macroGetTime%
%callMacro% ("t1 t2 elapsedTime") %macroDiffTime%


echo ---------------------------
echo elapsedTime = %elapsedTime%
pause