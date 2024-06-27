@echo off
:: https://stackoverflow.com/questions/3294599/do-batch-files-support-multiline-variables

::::::::::::::::::::::::::::::::::::
:::: newline (echo. version) :::::::
set \n=^&echo.

:: echo text with newlines
echo first line %\n%second line %\n%third line %\n%

:: variable with newlines (does not work with &echo. )
::set multi=Line1%\n%
::set multi=%multi%Line2%\n%
::set multi=%multi%Line3%\n%
::echo %multi%
pause


::::::::::::::::::::::::::::::::::::::::::::::::
:::: newline (delayed expansion version) :::::::
setlocal enableDelayedExpansion
set \n=^


rem two empty line required after set \n
:: echo text with newlines
echo first line !\n!second line !\n!third line !\n!

:: variable with newlines
set multi=Line1!\n!
set multi=!multi!Line2!\n!
set multi=!multi!Line3!\n!
echo !multi!

pause


:: https://stackoverflow.com/a/5642300
::::::::::::::::::::::::::::::::::::::::::::::::
:::: newline (without delayed expansion) :::::::
(SET LF=^
%=this line is empty=%
)
echo This text^%LF%%LF%uses two lines
echo This also^

has two lines

pause
