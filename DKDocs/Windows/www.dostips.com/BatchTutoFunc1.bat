@echo off
 
echo.going to execute myDosFunc
call:myDosFunc
echo.returned from myDosFunc
 
echo.&pause&goto:eof
 
::--------------------------------------------------------
::-- Function section starts below here
::--------------------------------------------------------
 
:myDosFunc    - here starts my function identified by it`s label
echo.  here the myDosFunc function is executing a group of commands
echo.  it could do a lot of things
goto:eof