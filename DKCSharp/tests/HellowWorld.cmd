@echo off
REM : Compile and run a C# source file.
REM : The C# compiler (csc.exe) must be in your PATH.
REM : The command line argument is expected to be something like foo.cs


set "file=%~1"

set "file=HelloWorld.cs"
if "%file%"=="" goto USAGE

:: find csc.exe
set "csc="
for /r "%SystemRoot%\Microsoft.NET\Framework\" %%# in ("*csc.exe") do  set "csc=%%#"
%csc% /nologo /out:%file%.exe  %file%
if ERRORLEVEL 1 goto EXIT

%file%.exe	%2  %3  %4  %5
goto EXIT

:USAGE
echo You must specify an argument representing the C# file you want to run.

:EXIT