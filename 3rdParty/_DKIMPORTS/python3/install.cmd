set "DIGITALKNOB_DIR=%HOMEDRIVE%%HOMEPATH%\digitalknob"
set "BRANCH=Development"

%DIGITALKNOB_DIR%\download\python-3.11.2-amd64.exe /quiet InstallAllUsers=1 PrependPath=1 TargetDir=%DIGITALKNOB_DIR%\%BRANCH%\3rdParty\python-3.11.2

