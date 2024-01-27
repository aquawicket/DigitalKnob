set "DIGITALKNOB=%HOMEDRIVE%%HOMEPATH%\digitalknob"
set "DKDOWNLOAD=%DIGITALKNOB%\download"
set "DKBRANCH=Development"
set "DKPATH=%DIGITALKNOB%\%DKBRANCH%"

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
::	set "DKPATH=%DIGITALKNOB%\%DKBRANCH%"
::	set "DKCMAKE=%DIGITALKNOB%\%DKBRANCH%\DKCMake"
::	echo DKBRANCH = %DKBRANCH%
::goto:eof

::call::validate_branch
%DKDOWNLOAD%\python-2.7.18.msi /passive PrependPath=1 TargetDir=%DKPATH%\3rdParty\python-2.7.18
::%SystemRoot%\System32\setx.exe PATH "%PATH%;%DKPATH%\3rdParty\python-2.7.18"