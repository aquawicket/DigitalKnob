:: Batch Code Line Debugging
:: Retrieve the batch file line number where the Line function is called.
:: by David Ruhmann

:: Hide Command and Isolate Scope
@echo off
setlocal

:: Usage Example
call :False xResult
if /i not "%xResult%" equ "false" (goto Done)
rem Capture the line number of the failure by offsetting to the relative line.
call Line xLine eUniqueLabel
echo "ERROR: False failed. Line: %xLine%." 1 "%Random%"

:Done
pause
goto End


::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:False <xReturn>
:: A function to return false to emulate calling a function that has a failure.
setlocal
set "xResult=false"
endlocal & if not "%~1" equ "" set "%~1=%xResult%"
goto:eof


:End
endlocal
:: by David Ruhmann