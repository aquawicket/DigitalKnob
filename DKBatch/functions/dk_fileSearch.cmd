@echo off
setlocal enableextensions
set "base_path=C:\Users\Administrator\digitalknob"
set "file_pattern=\bin\bash.exe"
set "search_depth=7"

::set file_pattern=%file_pattern:/=\%
for %%a in (%file_pattern:\= %) do set filename=%%a
set prefix=!file_pattern:%filename%=!


echo searching '%base_path%' for '%file_pattern%'
:: /s     =  copy Subdirectories, but not empty ones.
:: /fp    =  include Full Pathname of files in the output.
:: /l     =  List only - don't copy, timestamp or delete any files.
:: /lev:n =  only copy the top n LEVels of the source directory tree.
:: /nc    =  No Class - don't log file classes.
:: /ndl   =  No Directory List - don't log directory names.
:: /njh   =  No Job Header.
:: /njs   =  No Job Summary.
:: /ns    =  No Size - don't log file sizes.
echo:
echo Patern matched results
for /f "tokens=*" %%g in ('%systemroot%\system32\robocopy.exe "%base_path%" "null" "%filename%" /fp /l /lev:%search_depth% /nc /ndl /njh /njs /ns /s') do (
	set "string=%%g"
	if not "!string:%file_pattern%=!"=="!string!" (
		echo ***** %%g
		set "output=%%g"
	) else (
		echo %%g
	)
)
echo:
echo output = %output%
echo:
