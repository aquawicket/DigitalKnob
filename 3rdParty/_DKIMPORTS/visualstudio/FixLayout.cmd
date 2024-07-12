@echo off
call ..\..\..\DKBatch\functions\DK.cmd

start /wait %DKDOWNLOAD_DIR%\vs_Community.exe --layout "%DKDOWNLOAD_DIR%\digitalknob\Download\VisualStudio" --fix
