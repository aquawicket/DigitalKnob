@echo off


if exist %~d0dk_polyglot.bat del %~d0dk_polyglot.bat
if exist %~d0dk_polyglot.cmd del %~d0dk_polyglot.cmd
if exist %~d0dk_polyglot.ps1 del %~d0dk_polyglot.ps1
if exist %~d0dk_polyglot.sh  del %~d0dk_polyglot.sh

echo F|xcopy "%~d0dk_polyglot" "%~d0dk_polyglot.bat" /H /Y 1>nul 2>nul
echo F|xcopy "%~d0dk_polyglot" "%~d0dk_polyglot.cmd" /H /Y 1>nul 2>nul
echo F|xcopy "%~d0dk_polyglot" "%~d0dk_polyglot.ps1" /H /Y 1>nul 2>nul
echo F|xcopy "%~d0dk_polyglot" "%~d0dk_polyglot.sh" /H /Y 1>nul 2>nul

echo:
echo ###### dk_polyglot.bat ######
cmd /c call dk_polyglot.bat

echo:
echo ###### dk_polyglot.cmd ######
call dk_polyglot.cmd

echo:
echo ###### dk_polyglot.cmd ######
powershell ".\dk_polyglot.ps1"


echo:
echo ###### dk_polyglot.cmd ######
bash dk_polyglot.sh
