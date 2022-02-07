%DKBATCH%
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
set "output=peach"
endlocal & set "%1=%output%"

%DKEND%
