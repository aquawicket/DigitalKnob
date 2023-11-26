@echo off
%dkbatch%

echo Refreshing windows icons

:: for window
ie4uinit.exe -ClearIconCache

:: for windows 10+
ie4uinit.exe -show
