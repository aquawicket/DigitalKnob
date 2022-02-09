%DKBATCH%
:: https://github.com/ClicketyClickDK/Underscore




::call Sleep 2
echo:


::set "ERRORLEVEL=1"
::%IF_ERROR% "IF_ERROR: This throws an error if ERRLVL in not 0, and continues"
::echo: 

::%ERROR% "ERROR: This throws an error, and continues"
::echo:

::set "ERRORLEVEL=1"
::%IF_FATAL% "IF_FATAL: This thows an error if ERRLVL in not 0, and exits the program"
::echo:

::%FATAL% "FATAL: This throws an error, and exits the program"
::echo:


call NestedNodes1

echo:

call dkprint this is a test of dkprint

echo:

copy NUL %DKBATCH_PATH%CATCH\EmptyFile.txt

echo:

call TEMPLATE 369 string result
echo TemplateFunc returned: %result%

echo:

::call Sleep 2

echo:

call SendData apple

echo:

::call Sleep 2

echo:

call GetData result 
echo GetData returned: %result%

echo:

::call Sleep 2

echo:

call SendAndGetData orange result
echo SendAndGetData returned: %result%

echo:

::call Sleep 2

echo:

call Color :ShowColors

echo:

::call Sleep 2

echo:

:end
%DKEND%
