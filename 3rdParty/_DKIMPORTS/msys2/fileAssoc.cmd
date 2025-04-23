@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%A IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpA")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::#################################################################################################################################################


:: https://ss64.com/nt/ftype.html
FTYPE shellscript=%DK3RDPARTY%\msys2-x86_64-20231026\clang64.exe "%%1"

assoc .sh=shellscript
assoc .bash=shellscript
