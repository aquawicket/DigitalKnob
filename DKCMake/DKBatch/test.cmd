%DKBATCH%
:: https://github.com/ClicketyClickDK/Underscore
call Sleep 2

call dkprint this is a test

echo Calling "TemplateFunc 369 string result"
call TEMPLATE 369 string result
echo TemplateFunc returned: %result%
echo:

call Sleep 2

echo Calling "SendData apple"
call SendData apple
echo:

call Sleep 2

echo Calling "GetData result"
call GetData result 
echo GetData returned: %result%
echo:

call Sleep 2

echo Calling "SendAndGetData orange result"
call SendAndGetData orange result
echo SendAndGetData returned: %result%
echo:

call Sleep 2

call Color :ShowColors

call Sleep 2


::%DKOUT%
%DKEND%
