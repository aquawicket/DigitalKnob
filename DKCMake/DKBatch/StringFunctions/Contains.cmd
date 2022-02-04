:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:Contains "string" "searchVal" result
::
:: Func: returns true if searchVal is in string
::
:: Example:  call Contains boy "see the boy run" result
::           echo Contains returned: %result%
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
%DKBATCH%
if %DEBUG%==1 echo -^> %~n0()


set string=%~1
set searchVal=%~2
if %DEBUG%==1 echo Contains(string: %string%;  searchVal: %searchVal%;  result: %result%) & echo:
set result=0
if not "x!string:%searchVal%=!"=="x%string%" set result=1
if "%string%"=="" set result=0
if %DEBUG%==1 echo Contains()result: %result% & echo:
endlocal & set %3=%result%


if %DEBUG%==1 echo ^<- %~n0()
goto :EOF
