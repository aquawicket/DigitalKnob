@echo off
if not defined in_subprocess (cmd /k set in_subprocess=y ^& %0 %*) & exit ) :: keep window open

set "DIGITALKNOB=%HOMEDRIVE%%HOMEPATH%\digitalknob"
%DIGITALKNOB%\Development\DKCMake\dev\cmake_eval "include('%DIGITALKNOB%/Development/3rdParty/_DKIMPORTS/msys2/DKMAKE.cmake')"

