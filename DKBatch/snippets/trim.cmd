@echo off
setlocal EnableDelayedExpansion

set "x=   String    with     spaces      "

set "x=%x% "
set "i=0"
set "j="
set "w=%x: =" & (if not defined w (if not defined j (set /A i+=1) else set /A j+=1) else set j=1) & set "w=%"
set "x2=!x:~%i%,-%j%!"

echo "%x:~0,-1%"
echo "%x2%"
pause