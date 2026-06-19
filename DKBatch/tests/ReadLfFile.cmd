@echo off

setlocal EnableExtensions EnableDelayedExpansion
for /f "usebackq delims=" %%a in ("%~f0") do (
  set /a c+=1
  set x[!c!]=%%a
)
set x

pause
