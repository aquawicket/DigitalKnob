@echo off
if not defined in_subprocess (cmd /k set in_subprocess=y ^& %0 %*) & exit ) :: keep window open

set "DIGITALKNOB_DIR=%HOMEDRIVE%%HOMEPATH%\digitalknob"
%DIGITALKNOB_DIR%\Development\DKCMake\dev\cmake_eval "include('%DIGITALKNOB_DIR%/Development/3rdParty/_DKIMPORTS/msys2/DKMAKE.cmake')"

cmake -E create_symlink %HOMEDRIVE%%HOMEPATH%\digitalknob\Development\3rdParty\libjpeg-turbo-main\win_x86_64\Debug\jconfig.h %HOMEDRIVE%%HOMEPATH%\digitalknob\Development\3rdParty\libjpeg-turbo-main\win_x86_64\Debug\jconfig.h