%DKBATCH%
:: https://github.com/ClicketyClickDK/Underscore
call Sleep 2

echo:

%ERROR% "the error message"

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
