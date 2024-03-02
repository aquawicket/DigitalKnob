set "DIGITALKNOB_DIR=%HOMEDRIVE%%HOMEPATH%\digitalknob"
set "DKDOWNLOAD_DIR=%DIGITALKNOB_DIR%\download"
set "DKBRANCH=Development"
set "DKBRANCH_DIR=%DIGITALKNOB_DIR%\%DKBRANCH%"

:: validate_branch()
:::validate_branch
::	:: https://stackoverflow.com/a/33662275
::	:: If the current folder matches the current branch set DKBRANCH, default to Development
::	for %%I in (.) do set "FOLDER=%%~nxI"
::	git branch | find "* %FOLDER%" > NUL & IF ERRORLEVEL 1 (
::		set "DKBRANCH=Development"
::	) else (
::		set "DKBRANCH=%FOLDER%"
::	)
::	set "DKBRANCH_DIR=%DIGITALKNOB_DIR%\%DKBRANCH%"
::	set "DKCMAKE_DIR=%DKBRANCH_DIR%\DKCMake"
::	echo DKBRANCH = %DKBRANCH%
::goto:eof

::call::validate_branch
%DKDOWNLOAD_DIR%\python-2.7.18.msi /passive PrependPath=1 TargetDir=%DKBRANCH_DIR%\3rdParty\python-2.7.18
::%SystemRoot%\System32\setx.exe PATH "%PATH%;%DKBRANCH_DIR%\3rdParty\python-2.7.18"