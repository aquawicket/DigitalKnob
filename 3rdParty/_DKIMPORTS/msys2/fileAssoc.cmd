@echo off
set "DIGITALKNOB_DIR=C:\\Users\\aquawicket\\digitalknob"

:: https://ss64.com/nt/ftype.html
FTYPE shellscript=%DIGITALKNOB_DIR%\Development\3rdParty\msys2-x86_64-20231026\clang64.exe "%%1"

assoc .sh=shellscript
assoc .bash=shellscript
