@echo off

call :SetLineNumbers

set lineNumber=0
echo %lineNumber%

set lineNumber=0
echo %lineNumber%

for %%G in ( 1 2 3) DO (
   set lineNumber=0
)
echo %lineNumber%







set lineNumber=0
echo %lineNumber%

pause

exit /b


:SetLineNumbers
setlocal EnableDelayedExpansion

set "anyChange="
set "equal=="
set lastLine=0
< "%~F0" (
   for /F "delims=:" %%a in ('findstr /N /I /C:"set lineNumber%equal%" "%~F0"') do (
      set /A lines=%%a-lastLine-1, lastLine=%%a
      for /L %%i in (1,1,!lines!) do (
         set "line="
         set /P "line="
         echo(!line!
      )
      set /P "line="
      for /F "tokens=2 delims==" %%b in ("!line!") do (
         if "%%b" neq "%%a" (
            set "line=!line:%%b=%%a!"
            set "anyChange=true"
         )
      )
      echo !line!
   )
   findstr "^"
) > temp.tmp
if defined anyChange (
   move /Y temp.tmp "%~F0" > NUL
   exit /B
) else (
   del temp.tmp
)
exit /B
