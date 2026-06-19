@echo off

set "aStr=Expect no changed, even if used in function"
set "var1=Expect changed"
echo.aStr before: %aStr%
echo.var1 before: %var1%
call:myGetFunc var1
echo.aStr after : %aStr%
echo.var1 after : %var1%
 
echo.&pause&goto:eof

::--------------------------------------------------------
::-- Function section starts below here
::--------------------------------------------------------

:myGetFunc    - passing a variable by reference
SETLOCAL
set "aStr=DosTips"
( ENDLOCAL
    set "%~1=%aStr%"
)
goto:eof

:myGetFunc2    - passing a variable by reference
SETLOCAL
set "aStr=DosTips"
ENDLOCAL&set "%~1=%aStr%"       &rem THIS ALSO WORKS FINE
goto:eof