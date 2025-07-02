:: https://stackoverflow.com/a/20333575/688352
@echo off

echo Deleting deleteSelf.cmd . . .
call :deleteSelf&exit /b
:deleteSelf
start /b "" cmd /c del "%~f0"&exit /b 10
