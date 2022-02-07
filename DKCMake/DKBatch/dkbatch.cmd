@echo off
set DEBUG=1
::if %DEBUG%==1 echo -^> %~n0()
set "DKIN=if %DEBUG%==1 echo -^> %~n1()"
set "DKOUT=if %DEBUG%==1 echo ^<- %~n1()"
if defined DKINIT goto :EOF
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:dkbatch
::
:: Func: Sets up the DKBatch library environment
::
:: Example:  call dkbatch
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

set caller=%0
if not "%1"=="" set "caller=%1"
if not defined in_subprocess (cmd /k set in_subprocess=y ^& %caller% %*) & exit )

set "DKINIT=@setlocal enableextensions enabledelayedexpansion"
%DKINIT%

set "onError=if errorlevel 1 echo echo ^<ESC^>[91m [91m ERROR: The last command failed [0m 

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



::if %DEBUG%==1 echo ^<- %~n0()
