:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:Sleep seconds
::
:: Func: Suspends batch execution for a number of seconds.
::
:: Args: %1 Number of seconds to wait for (by val)
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
setlocal ENABLEEXTENSIONS 
set /a n=%1+1
echo Sleeping for %1 seconds . . .
ping -n %n% 127.0.0.1 >nul
endlocal 
goto :EOF
