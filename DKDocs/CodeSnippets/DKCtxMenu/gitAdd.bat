ECHO off && cls

echo adding %1 to the git repository . . .

set "DIGITALKNOB_DIR=%HOMEDRIVE%%HOMEPATH%\digitalknob"
::echo DIGITALKNOB_DIR = %DIGITALKNOB_DIR%

set GIT_EXE=git

"%GIT_EXE%" add %1
@echo Added %1 to repository

pause