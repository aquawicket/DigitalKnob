:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:dkbatch
::
:: Func: Sets up the DKBatch library environment
::
:: Example:  call dkbatch
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@echo off
if not defined in_subprocess (cmd /k set in_subprocess=y ^& %0 %*) & exit )

set DEBUG=1

echo *****************************
echo ********** dkbatch **********
echo *****************************
echo:
if %DEBUG%==1 echo *** DEBUG MODE ON ***

:: add root of dkbatch to global environment variables, and subfolders to local environment variables
@setlocal enableextensions enabledelayedexpansion
::call %~dp0\StringFunctions\Contains "%PATH%" %~dp0 result
::if "%result%"=="0" (setx PATH "%PATH%";%~dp0)
call %~dp0\StringFunctions\Contains "%DKBATCH%" "%~dp0\dkbatch.cmd" result
if "%result%"=="0" (setx DKBATCH "%~dp0\dkbatch.cmd")
endlocal
set "PATH=%PATH%;%~dp0;%~dp0\TestFunctions;%~dp0\StringFunctions;%~dp0\SystemFunctions"


goto :EOF
