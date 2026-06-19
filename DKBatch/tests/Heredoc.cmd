@echo off

rem Definition of heredoc macro
setlocal DisableDelayedExpansion
set LF=^


::Above 2 blank lines are required - do not remove
set ^"\n=^^^%LF%%LF%^%LF%%LF%^^"
set heredoc=for %%n in (1 2) do if %%n==2 (%\n%
       for /F "tokens=1,2" %%a in ("!argv!") do (%\n%
          if "%%b" equ "" (call :heredoc %%a) else call :heredoc %%a^>%%b%\n%
          endlocal ^& goto %%a%\n%
       )%\n%
    ) else setlocal EnableDelayedExpansion ^& set argv=


rem Heredoc syntax:
rem
rem %%heredoc%% :uniqueLabel [outfile]
rem contents
rem contents
rem ...
rem :uniqueLabel
rem
rem Same notes of rojo's answer apply

rem Example borrowed from rojo's answer:

set bodyText=Hello world!
set lipsum=This is an example of a batch script HereDoc

%heredoc% :endHtml out.html
<html lang="en">
    <body>
        <h3>!bodyText!</h3>
        <p>!lipsum!</p>
    </body>
</html>
:endHtml

echo File created:
start "" /b /wait /min out.html
::del out.html
pause
goto :EOF


rem Definition of heredoc subroutine

:heredoc label
set "skip="
for /F "delims=:" %%a in ('findstr /N "%1" "%~F0"') do (
   if not defined skip (set skip=%%a) else set /A lines=%%a-skip-1
)
for /F "skip=%skip% delims=" %%a in ('findstr /N "^" "%~F0"') do (
   set "line=%%a"
   echo(!line:*:=!
   set /A lines-=1
   if !lines! == 0 exit /B
)
exit /B