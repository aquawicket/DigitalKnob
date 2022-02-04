%DKBATCH%
%DKIN% %~n0()
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:TEMPLATE in1 in2 out1
::
:: Func:  *description*
::
:: in1:   *description*
:: in2:   *description*
:: out1:  *description* 
::
:: Example:  call TEMPLATE someValue "anotherValue" theResult
::           echo TEMPLATE returned: %theResult%
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
set "in1=%~1"
set "in2=%~2"
::if %DEBUG%==1 echo TEMPLATE(in1: %in1%;  in2: %in2%;  out1: %out1%)
echo     TEMPLATE(in1: %in1%;  in2: %in2%)

set "out1=someOutputValue"

::if %DEBUG%==1 echo Contains()result: %result%
echo     TEMPLATE(out1: %out1%)
endlocal & set "%3=%out1%"


%DKOUT% %~n0()
goto :EOF
