@echo off
call ..\..\..\DKBatch\functions\DK.cmd

:: https://ss64.com/nt/ftype.html
FTYPE shellscript=%DK3RDPARTY%\msys2-x86_64-20231026\clang64.exe "%%1"

assoc .sh=shellscript
assoc .bash=shellscript
