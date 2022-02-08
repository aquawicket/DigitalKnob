:: https://docs.microsoft.com/en-us/windows-server/administration/windows-commands/windows-commands
:: https://home.csulb.edu/~murdock/dosindex.html
:: https://ss64.com/nt/

@echo off
::echo %1 %2 %3
set DEBUG=1
for /f "tokens=1,* delims= " %%a in ("%*") do set ALL_BUT_FIRST=%%b
set "DKIN=if %DEBUG%==1 echo -^> %~n1^(%ALL_BUT_FIRST%^)"
::TODO - try and get the return values printed in the echo below

set "DOEND=if %DEBUG%==1 echo ^<- %~n1^(^)"
::set "DOERROR=echo ERROR: %~n1 %3 & goto :EOF"
if "%2"=="DKEND" %DOEND% & goto :EOF
::if "%2"=="DKERROR" %DOERROR% & goto :EOF
set "DKEND=call %0 %%0 DKEND"
::set "DKERROR=call %0 %%0 DKERROR %2"

if defined DKLOADED (
	::set "PARENT=%PREV%" set "PREV=%~n1"
	%DKIN% & TITLE %1 & goto :EOF
)
set caller=%0
if not "%1"=="" set "caller=%1"
::if not defined in_subprocess (cmd /k set in_subprocess=y ^& %caller% %* > log.txt 2>&1) & exit )
if not defined in_subprocess (cmd /k set in_subprocess=y ^& %caller% %*) & exit )
%DKIN%

set "ERROR=DKERROR %1 "

::echo *****************************
::echo ********** dkbatch **********
::echo *****************************
if %DEBUG%==1 echo *** DEBUG MODE ON ***
echo:

:: add %DKBATCH% command to global environment variables
if "%DKBATCH%"=="" setx DKBATCH "@echo off & call %0 %%0 & @setlocal enableextensions enabledelayedexpansion"

:: Add dkbatch subfolders to the PATH environment variable
set "PATH=%PATH%;%~dp0;%~dp0\TestFunctions;%~dp0\StringFunctions;%~dp0\SystemFunctions"




:::::::::::::::::::::::::::::::::::::::::::::::::

@setlocal enableextensions enabledelayedexpansion

:: anything that needs a private scope to dkbatch should be done here

endlocal
::::::::::::::::::::::::::::::::::::::::::::::::
set DKLOADED=1
::if %DEBUG%==1 echo ^<- %~n0()
