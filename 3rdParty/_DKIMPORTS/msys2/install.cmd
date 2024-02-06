@echo off
if not defined in_subprocess (cmd /k set in_subprocess=y ^& %0 %*) & exit ) :: keep window open

set "DIGITALKNOB=%HOMEDRIVE%%HOMEPATH%\digitalknob"
%DIGITALKNOB%\Development\DKCMake\dev\cmake_eval "include('%DIGITALKNOB%/Development/3rdParty/_DKIMPORTS/msys2/DKMAKE.cmake')"

cmake -E create_symlink C:\Users\aquawicket\digitalknob\Development\3rdParty\libjpeg-turbo-main\win64\Debug\jconfig.h C:\Users\aquawicket\digitalknob\Development\3rdParty\libjpeg-turbo-main\win64\Debug\jconfig.h