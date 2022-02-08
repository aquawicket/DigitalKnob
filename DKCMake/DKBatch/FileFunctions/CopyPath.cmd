%DKBATCH%
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:CopyPath path
::
:: PosyPath: Automatically turns / slashes into backslashes to create directories
:: This is just for compatability and will not change your variables
::
:: path:  The path to the directory to create
::
:: Example:  call MakeDirectory C:/Test/Folder
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
set "src=%~1"
Set "dest=%~1"

set "path=%path:/=\%"
echo "%path%"
pause
mkdir "%path%"

endlocal
%DKEND%
