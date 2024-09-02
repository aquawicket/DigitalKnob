@echo off
call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0

start /wait %DKDOWNLOAD_DIR%\vs_Community.exe --layout "%DKDOWNLOAD_DIR%\digitalknob\Download\VisualStudio" --fix
