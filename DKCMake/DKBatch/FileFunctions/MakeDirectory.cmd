%DKBATCH%
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:MakeDirectory path
::
:: MakeDirectory: Automatically turns / slashes into backslashes to create directories
:: This is just for compatability and will not change your variables
::
:: path:  The path to the directory to create
::
:: Example:  call MakeDirectory C:/Test/Folder
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
set "path=%~1"

set "path=%variable:/=\%"
echo "%path%"
pause
mkdir "%path%"

endlocal
%DKEND%
