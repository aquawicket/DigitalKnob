%DKBATCH%
%DKIN%
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:SendAndGetData input output
::
:: Func: Takes a parameter, alters the value, and returns the result
::
:: input: The value to send to this function
:: output: variable(by ref) to receive the new value
::
:: Example:  call SendAndGetData orange rval
::           echo SendAndGetData returned: %rval%
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
set "input=%1"
echo    SendAndGetData received the value: %input%
set "output=%input%Tree"
endlocal & set "%2=%output%"

%DKOUT%
