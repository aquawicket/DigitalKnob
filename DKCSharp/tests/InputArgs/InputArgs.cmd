@echo off
REM : Compile and run a C# source file.
REM : The C# compiler (csc.exe) must be in your PATH.
REM : The command line argument is expected to be something like foo.cs


set "file=%~1"

set "file=InputArgs.cs"
if "%file%"=="" (goto USAGE)

:: find csc.exe
set "csc="
for /r "%SystemRoot%\Microsoft.NET\Framework\" %%# in ("*csc.exe") do  set "csc=%%#"
%csc% /nologo /out:%file%.exe  %file%
if ERRORLEVEL 1 (goto EXIT)


setlocal EnableDelayedExpansion
set "command=%file%.exe"
set i=0
for /f "usebackq delims=|" %%Z in (`%command% ^& call echo %%^^ERRORLEVEL%%`) do (
	set /a i+=1
	rem call set "line[%%i%%]=%%a"
	set "line[!i!]=%%Z"
)
set /a numLines=i-1
rem Final errorlevel is stored in last line
if !line[%i%]! gtr 0 (
   set /a lastline = !line[%i%]! 2>nul && %COMSPEC% /c exit %lastline%
) else (
   rem Process output lines
   for /L %%a in (1,1,%numLines%) do (
      echo Processing line %%a: !line[%%a]!
   )
)


echo errorlevel = %errorlevel%
if ERRORLEVEL -3 (echo ERRORLEVEL ^<= -3     'ERRORLEVEL is less than or equal to 3')
if ERRORLEVEL -2 (echo ERRORLEVEL ^<= -2     'ERRORLEVEL is less than or equal to 2')
if ERRORLEVEL -1 (echo ERRORLEVEL ^<= -1     'ERRORLEVEL is less than or equal to 1')
if ERRORLEVEL  0 (echo ERRORLEVEL  =  0)
if ERRORLEVEL  1 (echo ERRORLEVEL ^>=  1		'ERRORLEVEL is greater than or equal to 1')
if ERRORLEVEL  2 (echo ERRORLEVEL ^>=  2     'ERRORLEVEL is greater than or equal to 2')
if ERRORLEVEL  3 (echo ERRORLEVEL ^>=  3     'ERRORLEVEL is greater than or equal to 2')

