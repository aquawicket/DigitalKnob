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
set "dest=%~2"

set "src=%src:/=\%"
set "dest=%dest:/=\%"
echo CopyPath
echo "%src%"
echo "%dest%"
pause
copy "%src%" "%dest%"

endlocal
%DKEND%
