@if (@CodeSection == @Batch) @then


@echo off
setlocal EnableDelayedExpansion

rem APATee.bat: Asynchronous (real time) Tee program, Batch-javascript hybrid version
rem Antonio Perez Ayala

rem The advantage of this program is that the data management is written in Batch code,
rem so any Batch programmer may modify it to fit their own needs.
rem As an example of this feature, CLS command is correctly managed

if "%~1" equ "" (
   echo Duplicate the Stdout output of a command in the screen and a disk file
   echo/
   echo anyCommand ^| dk_tee log.txt [/A]
   echo/
   echo If /A switch is given, anyCommand output is *appended* to teeFile.txt
   goto :EOF
)

if "%2" equ ":TeeProcess" goto TeeProcess
   
rem Get the output of CLS command
for /F %%a in ('cls') do set "cls=%%a"

rem If /A switch is not provided, delete the file that receives Tee output
if /I "%~2" neq "/A" if exist %1 (del %1)

rem Create the semaphore-signal file and start the asynchronous Tee process
echo X > Flag.out
if exist Flag.in (del Flag.in)
Cscript //nologo //E:javascript "%~F0" | "%~F0" %1 :TeeProcess
del Flag.out
goto :EOF

:TeeProcess
   rem Wait for "Data Available" signal
   if not exist Flag.in (goto TeeProcess)
   rem Read the input line sent by javascript code
   set line=
   set /P line=
   rem Set "Data Read" acknowledgement
   rem Flag.in Flag.out
   rem Check for the standard "End Of piped File" mark
   if "!line!" equ ":_EOF_:" (exit /B)
   rem Correctly manage CLS command
   if "!line:~0,1!" equ "!cls!" (
      cls
      set "line=!line:~1!"
   )
   rem Duplicate input line in Stdout and the Tee output file
   echo(!line!
   echo(!line!>> %1
goto TeeProcess


@end


// javascript section

var fso = new ActiveXObject("Scripting.FileSystemObject");
// Process all lines of Stdin
while ( ! WScript.Stdin.AtEndOfStream ) {
   // Read the next line from Stdin
   var line = WScript.Stdin.ReadLine();
   // Wait for "Data Read" acknowledgement
   while ( ! fso.FileExists("Flag.out") ) {
      WScript.Sleep(10);
   }
   // Send the line to Batch code
   WScript.Stdout.WriteLine(line);
   // Set "Data Available" signal
   fso.MoveFile("Flag.out", "Flag.in");
}
// Wait for last "Data Read" acknowledgement
while ( ! fso.FileExists("Flag.out") ) {
      WScript.Sleep(10);
}
// Send the standard "End Of piped File" mark
WScript.Stdout.WriteLine(":_EOF_:");
fso.MoveFile("Flag.out", "Flag.in");