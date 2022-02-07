%DKBATCH%
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:SendData input
::
:: Func: Takes a parameter and prints the value to the screen
::
:: input: The value to send to this function
::
:: Example:  call SendData apple
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
set "input=%1"
echo    SendData received the value: %input%
endlocal

%DKOUT%
