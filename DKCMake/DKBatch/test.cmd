%DKBATCH%
:: https://github.com/ClicketyClickDK/Underscore
call Sleep 2

echo:


set "ERRORLEVEL=0" & echo ERRORLEVEL set to %ERRORLEVEL%
%IF_ERROR% "IF_ERROR: This throws an error if ERRLVL in not 0, and continues"
echo: 

echo Testing ERROR...
%ERROR% "ERROR: This throws an error, and continues"
echo:

echo Testing IF_FATAL...
set "ERRORLEVEL=0" & echo ERRORLEVEL set to %ERRORLEVEL%
%IF_FATAL% "IF_FATAL: This thows an error if ERRLVL in not 0, and exits the program"
::%IF_FATAL%
echo:

echo Testing FATAL...
%FATAL% "FATAL: This throws an error, and exits the program"
echo:

call NestedNodes1

echo:

call dkprint this is a test of dkprint

echo:

call TEMPLATE 369 string result
echo TemplateFunc returned: %result%

echo:

call Sleep 2

echo:

call SendData apple

echo:

call Sleep 2

echo:

call GetData result 
echo GetData returned: %result%

echo:

call Sleep 2

echo:

call SendAndGetData orange result
echo SendAndGetData returned: %result%

echo:

call Sleep 2

echo:

call Color :ShowColors

echo:

call Sleep 2

echo:

:end
%DKEND%
