@echo off

rem Assign a custom title.
::title This ^& That

rem Find the PID (process ID) of this cmd.exe session.
rem Note: A *temporary file* is required to capture the command output,
rem       for later parsing. A `for /f` command cannot be used DIRECTLY
rem       because it would execute the command in a *child* cmd.exe process, 
rem       which would report the wrong PID.
rem Get a path for a temporary file.
set TEMPFILE=~getpid_%DATE%%TIME%.txt
set TEMPFILE=%TEMPFILE:/=%
set TEMPFILE=%TEMPFILE::=%
set TEMPFILE=%TEMP%\%TEMPFILE: =%
WMIC process get Name,ParentProcessId | findstr "^WMIC\.exe" > "%TEMPFILE%"
for /f "tokens=2" %%i in (%TEMPFILE%) do set PID=%%i
del "%TEMPFILE%"

rem Now use the PID to look up process details, which includes the window title.
for /f "tokens=1,* delims=:" %%i in (
  'tasklist /fi "PID eq %PID%" /fo list /v ^| findstr "^Window Title:'
) do set thisTitle=%%j
rem Trim the leading space:
for /f "tokens=*" %%i in ("%thisTitle%") do set "thisTitle=%%i"

echo This window's title: "%thisTitle%"
pause