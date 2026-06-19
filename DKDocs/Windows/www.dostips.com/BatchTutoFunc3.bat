@echo off
 
set "var1=CmdTips"
echo.var1 before: %var1%
call:myGetFunc var1
echo.var1 after : %var1%
 
echo.&pause&goto:eof
 
 
::--------------------------------------------------------
::-- Function section starts below here
::--------------------------------------------------------
 
:myGetFunc    - passing a variable by reference
set "%~1=DosTips"
goto:eof