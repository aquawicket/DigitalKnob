@echo off

::Use %LINE:N=0%

set "LINE=N"
call :SetLineNumbers


echo %LINE%

echo %LINE:N=0%

echo %LINE:N=0%



for %%G in ( 1 2 3) DO (
   echo %LINE:N=0%
)
echo %LINE:N=0%






echo %LINE:N=0%

pause
exit /b


:SetLineNumbers
setlocal EnableDelayedExpansion

set "anyChange="
set "equal=="
set "percent=%%"
set "colon=:"
set lastLine=0
< "%~F0" (
   for /F "delims=:" %%a in ('findstr /N /I /C:"%percent%LINE%colon%N%equal%" "%~F0"') do (
      set /A lines=%%a-lastLine-1, lastLine=%%a
      for /L %%i in (1,1,!lines!) do (
         set "line="
         set /P "line="
         echo(!line!
      )
      set /P "line="
      for /F "tokens=2 delims==" %%b in ("!line!") do (
         if "%%b" neq "%%a" (
            set "line=!line:%%b=%%a!%percent%"
            set "anyChange=true"
         )
      )
      echo !line!
   )
   findstr "^"
) > temp.tmp
if defined anyChange (
   move /Y temp.tmp "%~dpn0_2.cmd" > NUL
   exit /B
) else (
   del temp.tmp
)
exit /B