@echo off
if not defined DKBATCH_FUNCTIONS_DIR_ (set "DKBATCH_FUNCTIONS_DIR_=..\..\..\DKBatch\functions\")
if not defined DKINIT (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*)

:: https://ss64.com/nt/ftype.html
FTYPE shellscript=%DK3RDPARTY%\msys2-x86_64-20231026\clang64.exe "%%1"

assoc .sh=shellscript
assoc .bash=shellscript
