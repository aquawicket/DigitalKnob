%DKBATCH%
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:EndProcess process error
::
:: Func:  Kill a process by process name
::
:: process:  the name of the task to kill.  I.E. cale.exe
:: error:    the error code if any
::
:: Example:  call EndProcess iexplore.exe error
::           echo EndProcess returned: %error%
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
if not defined %1 (
	echo ERROR: arg1 "process" invalid
	goto :EOF
)
set "process=%~1"

tasklist /fi "imagename eq %process%" |find ":" > nul
if errorlevel 1 taskkill /f /im "%process%


endlocal & set "%2=%ERRORLEVEL%"
%DKEND%
