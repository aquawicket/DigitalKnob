%DKBATCH%
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:RemoveDirectory path
::
:: RemoveDirectory: Automatically turns / slashes into backslashes.
::                  It will remove the directory and andy sub direcories and files
::
:: path:  The path to the directory to remove
::
:: Example:  call RemoveDirectory C:/Test/Folder
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
set "path=%~1"
set "path=%path:/=\%"
if EXIST "%path%" (
	rd /S /Q "%path%"
) else (
	echo ERROR: %0^(%path%^): The path does not exist
)


%DKEND%
