%DKBATCH%
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:TEMPLATE in1 in2 out1 out2
::
:: Func:  *description*
::
:: in1:   first input variable
:: in2:   second input variable
:: out1:  first output variable
:: out2:  second output variable
::
:: Example:  call TEMPLATE someValue "anotherValue" result1 result2
::           echo TEMPLATE returned: %result1% %result2%
:: 
::  Output:  TEMPLATE returned: someValue "anotherValue"
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
set "in1=%~1"
set "in2=%~2"
set "out1=%in1%"
set "out2=%in2%"

endlocal & set "%3=%out1%" & set "%4=%out2%" 
%DKEND%
