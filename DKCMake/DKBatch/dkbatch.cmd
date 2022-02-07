:: https://docs.microsoft.com/en-us/windows-server/administration/windows-commands/windows-commands
:: https://home.csulb.edu/~murdock/dosindex.html
:: https://ss64.com/nt/

@echo off
set DEBUG=1
set "DKIN=if %DEBUG%==1 echo -^> %~n1()"
set "DKOUT=if %DEBUG%==1 echo ^<- %~n1()"
set "onError=if errorlevel 1 echo echo ^<ESC^>[91m [91m ERROR: The last command failed & echo FILE: %~f1 [0m 
if defined DKLOADED (
	%DKIN% & TITLE %1 & goto :EOF
)
set caller=%0
if not "%1"=="" set "caller=%1"
::if not defined in_subprocess (cmd /k set in_subprocess=y ^& %caller% %* > log.txt 2>&1) & exit )
if not defined in_subprocess (cmd /k set in_subprocess=y ^& %caller% %*) & exit )
%DKIN%


echo *****************************
echo ********** dkbatch **********
echo *****************************
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
