@echo off & call %DKBATCH% %0
%DKINIT%


echo Calling "TemplateFunc 369 string result"
call TEMPLATE 369 string result
echo TemplateFunc returned: %result%
echo:

echo Calling "SendData apple"
call SendData apple
echo:

echo Calling "GetData result"
call GetData result 
echo GetData returned: %result%
echo:

echo Calling "SendAndGetData orange result"
call SendAndGetData orange result
echo SendAndGetData returned: %result%
echo:

call Color ShowColors
call Sleep 2
call Color :ShowColors
call Sleep 2
call Color :ShowColors2
call Sleep 2

::NOTE: What is this, find out how this works
::call Color:ColorChart
