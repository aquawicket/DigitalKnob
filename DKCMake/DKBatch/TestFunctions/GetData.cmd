:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:GetData output
::
:: Func: Takes a parameter and fills is with a value
::
:: output: variable(by ref) to receive the value
::
:: Example:  call GetData rval
::           echo GetData returned: %rval%
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
%DKBATCH%
if %DEBUG%==1 echo -^> %~n0()

set "output=peach"
endlocal & set "%1=%output%"

if %DEBUG%==1 echo ^<- %~n0()
goto :EOF
