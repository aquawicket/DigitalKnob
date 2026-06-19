@echo off
setlocal EnableDelayedExpansion

set "x=split string into substrings"

set "x=%x% "
set "x2="
set "word=%x: =" & set "x2=!x2!!word:~0,1!" & set "word=%" 

set x

pause