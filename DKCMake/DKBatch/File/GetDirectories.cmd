%DKBATCH%
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:GetDirectories path
::
:: GetDirectories: List the directories in the given path
::
:: path:  The path to list the directories in
::
:: Example:  call GetDirectories C:/Windows/Sysem32
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
set "path=%~1"

setlocal enabledelayedexpansion
for /d %%D in (%path%*) do ( set "folders=!folders!;%%D" ) 
endlocal & set "%1==%folders%"

%DKEND%