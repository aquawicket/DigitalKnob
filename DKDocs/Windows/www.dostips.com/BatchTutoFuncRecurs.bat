@echo off
 
set "fst=0"
set "fib=1"
set "limit=1000000000"
call:myFibo fib,%fst%,%limit%
echo.The next Fibonacci number greater or equal %limit% is %fib%.
 
echo.&pause&goto:eof
 
 
::--------------------------------------------------------
::-- Function section starts below here
::--------------------------------------------------------
 
:myFibo  -- calculate recursively the next Fibonacci number greater or equal to a limit
::       -- %~1: return variable reference and current Fibonacci number
::       -- %~2: previous value
::       -- %~3: limit
SETLOCAL
set /a "Number1=%~1"
set /a "Number2=%~2"
set /a "Limit=%~3"
set /a "NumberN=Number1 + Number2"
if /i %NumberN% LSS %Limit% call:myFibo NumberN,%Number1%,%Limit%
(ENDLOCAL
    IF "%~1" NEQ "" SET "%~1=%NumberN%"
)
goto:eof