::https://www.dostips.com/forum/viewtopic.php?p=67983#p67983
@echo off
setlocal EnableDelayedExpansion

set max=16
set nested=9
set "loop_base=for /L %%# in (1 1 %MAX%) do if not defined _break "
set loop_cnt=0
set "loop_cmd="
for /L %%# in (1 1 %nested%) do (
    set "loop_cmd=!loop_cmd!!loop_base!"
)
set "loop=set "_break=" & !loop_cmd!"

REM *** Tests begins ***
call :factorial 10 factor=
echo Factorial of 10: %factor%
echo/
echo/

call :lcm 3527 3784 var=
echo Least common multiple of 3527 and 3784: %var%
echo/
echo/

echo Calculation of e:
echo/
set /A digits=8, one=1
for /L %%i in (1,1,%digits%) do set one=!one!0
set /A num=0, fact=1, term=1, whileResult=0
echo #- #   term=1/#    summation
%loop% (
    set /A term=one/fact, whileResult+=term
    echo !num!- !fact!    !term!    !whileResult!
    set /A num+=1, fact*=num
    if !term! leq 0 set _break=1
)
echo/
echo Number e = !whileResult:~0,-%DIGITS%!.!whileResult:~-%DIGITS%!
echo/
echo/
pause
goto:eof

:factorial
setlocal

set num=1
set whileResult=1
%loop% (
    set /A whileResult*=num, num+=1
    if !num! gtr %1 set _break=1
)
endlocal & if "%2" neq "" (set %2=%whileResult%) else echo %whileResult%
exit /b

:lcm n1 n2 lcm=
setlocal
set /a "whileResult=%1, j=%2"

%loop% ( 
    set /a k=j, j=whileResult %% j, whileResult=k 
    if !j! equ 0 set _break=1
)
set /a j=%1*%2/whileResult
endlocal & if "%3" neq "" (set %3=%j%) else echo %j%
exit /B
