@echo off
setlocal EnableDelayedExpansion

set "x=   String    with     spaces      "
set "x=%x% "
set "x2="
set "word=%x: =" & (if "!word!" neq "" set "x2=!x2! !word!") & set "word=%" & set "x2=!x2:~1!"

echo "%x:~0,-1%"
echo "%x2%"
pause