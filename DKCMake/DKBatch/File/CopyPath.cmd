%DKBATCH%
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:CopyPath path
::
:: CosyPath: Automatically turns / slashes into backslashes and creates directories as needed
:: This is just for compatability and will not change your variables
::
:: path:  The path to the directory to create
::
:: Example:  call MakeDirectory C:/Test/Folder
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
set "src=%~1"
set "dest=%~2"
set "src=%src:/=\%"
set "dest=%dest:/=\%"
echo f | xcopy /f "%src%" "%dest%"
%IF_ERROR% ""

%DKEND%
