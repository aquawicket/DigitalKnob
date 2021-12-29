@echo off
if not defined in_subprocess (cmd /k set in_subprocess=y ^& %0 %*) & exit )

echo Refreshing windows icons

:: for window
ie4uinit.exe -ClearIconCache

:: for windows 10+
ie4uinit.exe -show
