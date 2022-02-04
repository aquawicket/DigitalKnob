:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:dkbatch
::
:: Func: Sets up the DKBatch library environment
::
:: Example:  call dkbatch
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
if defined DKINIT goto :EOF
set DKLOADED=1
@echo off
set caller=%0
if not "%1"=="" set "caller=%1"
if not defined in_subprocess (cmd /k set in_subprocess=y ^& %caller% %*) & exit )

set DEBUG=1
if %DEBUG%==1 echo -^> %~n0()


set "DKINIT=@setlocal enableextensions enabledelayedexpansion"
%DKINIT%

echo *****************************
echo ********** dkbatch **********
echo *****************************
if %DEBUG%==1 echo *** DEBUG MODE ON ***
echo:

:: add %DKBATCH% command to global environment variables
::call %~dp0\StringFunctions\Contains "%DKBATCH%" "%~dp0\dkbatch.cmd" result
::if "%result%"=="0" (setx DKBATCH "%~dp0\dkbatch.cmd")
::if "%result%"=="0" (setx DKBATCH "@echo off & call %~dp0\dkbatch.cmd %%0")
if "%DKBATCH%"=="" setx DKBATCH "@echo off & call %0 %%0"

endlocal
set "PATH=%PATH%;%~dp0;%~dp0\TestFunctions;%~dp0\StringFunctions;%~dp0\SystemFunctions"


if %DEBUG%==1 echo ^<- %~n0()
goto :EOF
