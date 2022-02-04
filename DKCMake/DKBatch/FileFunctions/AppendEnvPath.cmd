%DKBATCH%
if %DEBUG%==1 echo -^> %~n0()
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:AppendEnvPath path result
::
:: Func: Appends a path to the %PATH% environment variable
::
:: path:  a string containing the new path
::
:: Example:  call AppendEnvPath C:\Windows\System32 result
::           echo AppendEnvPath returned: %result%
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
set "path=%~1"
if %DEBUG%==1 echo AppendEnvPath(path: %path%)

call Contains "%PATH%\" "%path%" result
if not "%result%" == "1" (setx PATH "%PATH%";"%path%" >nul)
if not "%ERRORLEVEL%" == "0" (echo ERROR:%ERRORLEVEL% & goto :EOF)

if %DEBUG%==1 echo AppendEnvPath(result: %result%)
endlocal & set "%3=%result%"


if %DEBUG%==1 echo ^<- %~n0()
goto :EOF
