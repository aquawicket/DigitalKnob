set "DIGITALKNOB_DIR=%HOMEDRIVE%%HOMEPATH%\digitalknob"
set "DKDOWNLOAD_DIR=%DIGITALKNOB_DIR%\download"
set "DKBRANCH=Development"
set "DKBRANCH_DIR=%DIGITALKNOB_DIR%\%DKBRANCH%"

%DKDOWNLOAD_DIR%\download\python-3.11.2-amd64.exe /quiet InstallAllUsers=1 PrependPath=1 TargetDir=%DKBRANCH_DIR%\3rdParty\python-3.11.2
