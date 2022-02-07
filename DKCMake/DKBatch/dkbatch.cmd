if defined DKIN goto :EOF
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:dkbatch
::
:: Func: Sets up the DKBatch library environment
::
:: Example:  call dkbatch
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@echo off
set caller=%0
if not "%1"=="" set "caller=%1"
if not defined in_subprocess (cmd /k set in_subprocess=y ^& %caller% %*) & exit )

set DEBUG=1
set "DKIN=if %DEBUG%==1 echo -^> "
set "DKOUT=if %DEBUG%==1 echo ^<- "
%DKIN% %~n0()


set "DKINIT=@setlocal enableextensions enabledelayedexpansion"
%DKINIT%

echo *****************************
echo ********** dkbatch **********
echo *****************************
if %DEBUG%==1 echo *** DEBUG MODE ON ***
echo:

:: add %DKBATCH% command to global environment variables
if "%DKBATCH%"=="" setx DKBATCH "@echo off & call %0 %%0 & @setlocal enableextensions enabledelayedexpansion"

endlocal


:: Add dkbatch subfolders to the PATH environment variable
set "PATH=%PATH%;%~dp0;%~dp0\TestFunctions;%~dp0\StringFunctions;%~dp0\SystemFunctions"



%DKOUT% %~n0()
goto :EOF
