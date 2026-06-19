rem https://stackoverflow.com/a/20333575/688352
@echo off

echo Deleting Parent Folder . . .
call :deleteParentFolder&exit /b
:deleteParentFolder
start /b "" "%ComSpec%" /c rd /s /q "%~dp0"&exit /b 11
