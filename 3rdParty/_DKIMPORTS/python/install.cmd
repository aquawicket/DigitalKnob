set "DIGITALKNOB=%HOMEDRIVE%%HOMEPATH%\digitalknob"
set "DKDOWNLOAD=%DIGITALKNOB%\download"
set "DKBRANCH_DIR=Development"
set "DKPATH=%DIGITALKNOB%\%DKBRANCH_DIR%"

:: validate_branch()
:::validate_branch
::	:: https://stackoverflow.com/a/33662275
::	:: If the current folder matches the current branch set DKBRANCH_DIR, default to Development
::	for %%I in (.) do set "FOLDER=%%~nxI"
::	git branch | find "* %FOLDER%" > NUL & IF ERRORLEVEL 1 (
::		set "DKBRANCH_DIR=Development"
::	) else (
::		set "DKBRANCH_DIR=%FOLDER%"
::	)
::	set "DKPATH=%DIGITALKNOB%\%DKBRANCH_DIR%"
::	set "DKCMAKE_DIR=%DIGITALKNOB%\%DKBRANCH_DIR%\DKCMake"
::	echo DKBRANCH_DIR = %DKBRANCH_DIR%
::goto:eof

::call::validate_branch
%DKDOWNLOAD%\python-2.7.18.msi /passive PrependPath=1 TargetDir=%DKPATH%\3rdParty\python-2.7.18
::%SystemRoot%\System32\setx.exe PATH "%PATH%;%DKPATH%\3rdParty\python-2.7.18"