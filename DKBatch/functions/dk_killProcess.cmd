@echo off
call DK


:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:dk_killProcess process error
::
:: Func:  Kill a process by process name
::
:: process:  the name of the task to kill.  I.E. cale.exe
:: error:    the error code if any
::
:: Example:  call dk_endProcess iexplore.exe error
::           echo dk_endProcess returned: %error%
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
call dk_debugFunc
if %__ARGC__% NEQ 1 (call dk_error "%__FUNCTION__%(%__ARGC__%): too many arguments")
	
	
set "process=%~1"

tasklist /fi "imagename eq %process%" |find ":" >nul
if errorlevel 1 taskkill /f /im "%process%





:DKTEST ########################################################################

